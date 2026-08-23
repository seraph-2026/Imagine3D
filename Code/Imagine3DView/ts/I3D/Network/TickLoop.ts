import { BrowserView } from "../BrowserView/BrowserView";

export class TickLoop {
    browserView: BrowserView;
    tickLag?: number;
    private intervalId?: ReturnType<typeof setInterval>;

    constructor(browserView: BrowserView) {
        this.browserView = browserView;
    }

    clientTick(): void {
        if (this.browserView.clientState.browser.hasChanged) {
            this.browserView.clientState.browser.hasChanged = 0;
            this.browserView.reflectClientState();
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
