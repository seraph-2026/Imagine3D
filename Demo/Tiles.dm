
// Icons are from Aurora's Colossal Resource Pack
// https://beta.wolf3d.net/gallery/repo/186/4237

turf
	icon = 'Icons.dmi'

	Wall
		density = 1
		BlueBrick
			icon_state = "Blue Brick Wall"
			i3d_wall_icon_state = "Blue Brick Wall"
			i3d_floor_icon_state = "Concrete Floor"
			i3d_ceiling_icon_state = "Concrete Ceiling"

	Room
		Concrete
			icon_state = "Concrete Floor"
			i3d_floor_icon_state = "Concrete Floor"
			i3d_ceiling_icon_state = "Concrete Ceiling"

	Floor
		Concrete
			icon_state = "Concrete Floor Only"
			i3d_floor_icon_state = "Concrete Floor"

	Ceiling
		Ceiling
			icon_state = "Concrete Ceiling Only"
			i3d_ceiling_icon_state = "Concrete Ceiling"

	Open
		Empty
			icon_state = "Empty"

	Marker
		icon_state = "Marker"
		i3d_wall_icon_state = "Marker"
		i3d_floor_icon_state = "Marker"
		i3d_ceiling_icon_state = "Marker"
