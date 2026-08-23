export function initializeKeyEvents(): void {
    // Non repeatable so we don't spam BYOND's command system

    document.addEventListener("keydown", (keyEvent) => {
        if (keyEvent.repeat) return;

        const event = {
            browserViewId: 0,
            keyCode: keyEvent.code,
        };

        const eventToSend = JSON.stringify(event);

        BYOND.command(`keyDown ${eventToSend}`);
    });

    document.addEventListener("keyup", (keyEvent) => {
        if (keyEvent.repeat) return;

        const event = {
            browserViewId: 0,
            keyCode: keyEvent.code,
        };

        const eventToSend = JSON.stringify(event);

        BYOND.command(`keyUp ${eventToSend}`);
    });
}
