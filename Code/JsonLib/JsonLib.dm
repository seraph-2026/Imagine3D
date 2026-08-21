

datum
	proc
		/**
			Return all the j_ variables in this datum as a JSON object string
		**/
		toJsonString()
			return json_encode(JsonLib.serializeDm(src))

		/**
			Will copy across all variable values in the jsonString version of this datum
		**/
		fromJsonString(var/jsonString)
			var/datum/someDatum = JsonLib.deserializeJson(jsonString)
			for(var/variable in someDatum.vars)
				if(copytext(variable,1,3) == "j_")
					var/varValue = someDatum.vars[variable]
					src.vars[variable] = varValue



var/JsonLib/JsonLib = new()

JsonLib
	proc
		/**
			isEqualJson()

			Promises to return true if both A and B are equivalent when serialized into JSON.
		**/
		isEqualJson(var/datum/dmStructureA, var/datum/dmStructureB)
			return dmStructureA.toJsonString() == dmStructureB.toJsonString()

	proc
		/**
			serializeDm(dmStructure)

			Promises to return any DM structure as something which will safely
			encode into JSON using json_encode.

			If an object provided, only variables starting with j_ will be kept
		**/
		serializeDm(dmStructure)

			// Primitive types
			if(istext(dmStructure) || isnum(dmStructure) || isnull(dmStructure))
				return dmStructure

			// NaN = Not a number (special type)
			else if(isnan(dmStructure))
				return "NaN"

			// Encountered a list or object (objects count as associative lists)
			else if(islist(dmStructure))
				var/hasAssociations = listHasAssociations(dmStructure)

				// Array type, has no associations
				if(!hasAssociations)
					return serializeList(dmStructure)

				// Assocative list
				else if(hasAssociations)
					return serializeAList(dmStructure)

			// DM object (Datum)
			else if(istype(dmStructure, /datum))
				return serializeDatum(dmStructure)
			
				
		serializeDatum(someDatum)
			var/datum/dmDatum = someDatum // Start with this
			var/list/serializedDatum = list() // Convert to this

			serializedDatum["__DATUM__"] = 1
			serializedDatum["__TYPE__"] = dmDatum.type

			for(var/varName in dmDatum.vars)
				if(length(varName) > 2) // j_<variable> where variable must be at least one letter
					var/prefix = copytext(varName,1,3)

					if(prefix == "j_") // variable is tagged as json encodable
						var/varNameNoJ =  copytext(varName,3,0)
						var/varValue = dmDatum.vars[varName]

						serializedDatum[varNameNoJ] = serializeDm(varValue)

			return serializedDatum

		serializeList(var/list/someList)
			var/list/serializedList = new/list(someList.len) // Converting to this

			for(var/i in 1 to someList.len)
				var/item = someList[i]
				serializedList[i] = serializeDm(item)

			return serializedList

		serializeAList(var/list/someList)
			var/list/serializedAlist = alist() // Converting to this

			for(var/key in someList)
				var/association = someList[key]
				serializedAlist[key] = serializeDm(association)

			return serializedAlist

		/**
			Return true if list is associative, false if not
		**/
		listHasAssociations(list/anyList)
			for(var/key, value in anyList)
				if(!isnull(value))
					return TRUE

			return FALSE

JsonLib
	proc
		/**
			deserializeJson(jsonString)

			Promises to return the DM representation of jsonString,
			including primitives, objects and lists.

			All variables will start with j_
		**/
		deserializeJson(var/jsonString)
			var/list/jsonDecoded = json_decode(jsonString)

			// Primitive types
			if(istext(jsonDecoded) || isnum(jsonDecoded) || isnull(jsonDecoded))
				return jsonDecoded
			
			// Object type
			else if(jsonDecoded["__DATUM__"] == 1 &&  jsonDecoded["__TYPE__"])
				return deserializeDatum(jsonDecoded)
			
			// List of either type
			else if(islist(jsonDecoded))

				var/hasAssociations = listHasAssociations(jsonDecoded)

				// List (array)
				if(!hasAssociations)
					return deserializeList(jsonDecoded)
				
				// Associative List (alist)
				else if (hasAssociations)
					return deserializeAList(jsonDecoded)
			
			else
				throw EXCEPTION("Failed to deserialize JSON as it contains an unsupported type. Located in: (jsonString)")
				return
		
		deserializeDatum(var/datumAsList)
			var/datumType = datumAsList["__TYPE__"]
			if(!datumType) throw EXCEPTION("Failed to deserialize JSON string. Missing __TYPE__ on __DATUM__ tagged entry.")
			
			var/datum/newDatum = new datumType
			
			for(var/key in datumAsList)
				if(key == "__DATUM__" || key == "__TYPE__")
					continue

				newDatum.vars["j_" + key] = deserializeJson(json_encode(datumAsList[key]))
			
			return newDatum
		
		deserializeList(var/list/someList)
			var/list/deserializedList = new/list(someList.len)
			
			// Combine both list(array) and alist into a single list
			for(var/i in 1 to someList.len)
				var/item = someList[i]
				deserializedList[i] = deserializeJson(json_encode(item))

			return deserializedList

		deserializeAList(var/list/someAList)
			var/list/deserializedAlist = list()

			for(var/key in someAList)
				deserializedAlist[key] = deserializeJson(json_encode(someAList[key]))

			return deserializedAlist

