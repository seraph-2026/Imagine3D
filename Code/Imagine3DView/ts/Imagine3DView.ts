import { view } from "./BrowserView/BrowserView";
import { renderer } from "./Renderer/Renderer";
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
        renderer.animate();
        renderer.requestPointerLock();
        renderer.resizeToFitScreen();
        initializeKeyEvents();
    }
}, 10);
