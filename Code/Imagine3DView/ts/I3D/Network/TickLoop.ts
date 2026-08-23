import { BrowserView } from "../../BrowserView/BrowserView";
import { manager } from "../I3DManager";

export class TickLoop {
    tickLag?: number;
    private intervalId?: ReturnType<typeof setInterval>;

    clientTick(): void {
        if (manager.browserView.clientState.hasChanged) {
            manager.browserView.clientState.hasChanged = 0;
            manager.browserView.reflectClientState();
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
