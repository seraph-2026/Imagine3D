import { view } from "../BrowserView/BrowserView";
export function initializeKeyEvents() {
    // Non repeatable so we don't spam BYOND's command system
    document.addEventListener("keydown", (keyEvent) => {
        if (keyEvent.repeat)
            return;
        const event = {
            browserViewId: view.state.browserViewId,
            keyCode: keyEvent.code,
        };
        const eventToSend = JSON.stringify(event);
        BYOND.command(`captureKeyDown ${eventToSend}`);
    });
    document.addEventListener("keyup", (keyEvent) => {
        if (keyEvent.repeat)
            return;
        const event = {
            browserViewId: view.state.browserViewId,
            keyCode: keyEvent.code,
        };
        const eventToSend = JSON.stringify(event);
        BYOND.command(`captureKeyUp ${eventToSend}`);
    });
}
//# sourceMappingURL=KeyDown.js.map