import { renderer } from "./I3D/Renderer/Renderer";
import { map } from "./I3D/Renderer/Map";
import { initializeKeyEvents } from "./BrowserView/KeyHandling/KeyDown";
console.log("Imagine3DView");
console.log("- Successfully started");
/**
 * Begin rendering once we've got a map
 */
const mapLoadInterval = setInterval(() => {
    if (map.isLoaded) {
        clearInterval(mapLoadInterval);
        console.log("- Beginning animation");
        renderer.animate();
        renderer.requestPointerLock();
        renderer.resizeToFitScreen();
        console.log(window.view.state);
        if (window.view?.state?.settings?.mouseLookEnabled === 1) {
            renderer.cameraManager.enableMouseLook();
        }
        initializeKeyEvents();
    }
}, 10);
//# sourceMappingURL=Run.js.map