import * as I3D from "./I3D";
import { initializeKeyEvents } from "./I3D/BrowserView/KeyHandling/Keys";

console.log("Imagine3DView");
console.log("- Successfully started");

/**
 * Begin rendering once we've got a map
 */
const mapLoadInterval = setInterval(() => {
    if (I3D.manager.map.isLoaded) {
        clearInterval(mapLoadInterval);

        console.log("- Beginning animation");

        I3D.manager.renderer.animate();
        I3D.manager.renderer.requestPointerLock();
        I3D.manager.renderer.resizeToFitScreen();

        if (window.view?.gameState?.settings?.mouseLookEnabled === 1) {
            I3D.manager.renderer.cameraManager.enableMouseLook();
        }

        initializeKeyEvents();
    }
}, 10);
