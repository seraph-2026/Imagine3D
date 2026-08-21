import { view } from "./BrowserView/BrowserView";
import { i3d_renderer } from "./Renderer/I3D_Renderer";
import { map } from "./Renderer/Map";
import { initializeKeyEvents } from "./KeyHandling/KeyDown";

console.log("Imagine3DView");
console.log("- Successfully started");

/**
 * Begin rendering once we've got a map
 */
const mapLoadInterval = setInterval(() => {
    if (map.isLoaded) {
        clearInterval(mapLoadInterval);

        console.log("- Beginning animation");
        i3d_renderer.animate();
        i3d_renderer.requestPointerLock();
        i3d_renderer.resizeToFitScreen();
        i3d_renderer.cameraManager.enableMouseLook();
        initializeKeyEvents();
    }
}, 10);
