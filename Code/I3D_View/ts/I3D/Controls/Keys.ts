export function initializeKeyEvents(): void {
    // Non repeatable so we don't spam BYOND's command system

    document.addEventListener("keydown", (keyEvent) => {
        console.log("Key down");
        if (keyEvent.repeat) return;

        BYOND.command(`keyDown ${keyEvent.code}`);
    });

    document.addEventListener("keyup", (keyEvent) => {
        if (keyEvent.repeat) return;

        BYOND.command(`keyUp ${keyEvent.code}`);
    });
}
