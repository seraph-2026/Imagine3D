import { StateManager } from "../State/StateManager";

export class TickLoop {
    stateManager: StateManager;
    tickLag?: number;
    private intervalId?: ReturnType<typeof setInterval>;

    constructor(stateManager: StateManager) {
        this.stateManager = stateManager;
    }

    clientTick(): void {
        if (this.stateManager.clientState.browser.hasChanged) {
            this.stateManager.clientState.browser.hasChanged = 0;
            this.stateManager.reflectClientState();
        }
    }

    start(tickLag: number): void {
        if (!this.intervalId) {
            this.tickLag = tickLag;
            const timeToWaitMs = this.tickLag * 100;

            this.intervalId = setInterval(() => {
                this.clientTick();
            }, timeToWaitMs);
        } else {
            throw Error("Tick interval already in progress");
        }
    }

    stop(): void {
        if (this.intervalId) {
            clearInterval(this.intervalId);
            this.intervalId = undefined;
        } else {
            throw Error("No tick interval to stop");
        }
    }
}
