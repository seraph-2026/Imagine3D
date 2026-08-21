
// /**
//     If using the built-in movement system, every movable gets a
//     bound box which is smaller than the whole tile and can be
//     adjusted.
// **/
// atom/movable
//     var
//         vector/id3_collision_box // Pixel width and height of collision box from center
    
//     New()
//         ..()
//         if(Imagine3D.movementEnabled)

//             var/vector/worldIconSizeVector = i3d_splitX(world.icon_size)
//             var/vector/collisionBoxVector
            
//             // Use what we have
//             if(id3_collision_box)
//                 collisionBoxVector = id3_collision_box

//                 // Apply bounding box
//                 src.bound_width = collisionBoxVector.x 
//                 src.bound_height = collisionBoxVector.y
                
//                 // Pad it evenly on all four sides
//                 src.bound_x = round((worldIconSizeVector.x - bound_width) / 2)
//                 src.bound_y = round((worldIconSizeVector.y - bound_height) / 2)

            
//             // Or if there's no collision radius set up, default to half world icon_size
//             else if(!id3_collision_box)

//                 collisionBoxVector = vector(worldIconSizeVector.x, worldIconSizeVector.y)
                
//                 collisionBoxVector.x = 0.5 * round(collisionBoxVector.x)
//                 collisionBoxVector.y = 0.5 * round(collisionBoxVector.y)
                
//             // Apply bounding box
//             src.bound_width = collisionBoxVector.x  // 32
//             src.bound_height = collisionBoxVector.y // 32
            
//             // Pad it evenly on all four sides
//             icon_w = round((worldIconSizeVector.x - bound_width) / 2)
//             icon_z  = round((worldIconSizeVector.y - bound_height) / 2)

//             world << "bound_width[bound_width] bound_height[bound_height] icon_w[icon_w] icon_z[icon_z]"
