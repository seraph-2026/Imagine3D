import { manager } from "../I3D";
import { ClientStateJson } from "../I3D/Transport/ClientStateJson";

export class BrowserView {
    gameState: {
        [key: string]: any;
    } = {};

    clientState: ClientStateJson = {
        browser: {
            windowId: null,
            controlId: null,
            isReady: null,
        },
        tickLag: null,
        hasChanged: 0,
    };

    constructor() {
        console.log("BrowserView");
        console.log("- Successfully created");
        console.log("- Listening for state changes");
    }

    // Name is not used but is required by DM
    setGameState(_name: string, value: string): void {
        console.log("- Setting game state");

        try {
            this.gameState = JSON.parse(decodeURIComponent(value));
        } catch (exception) {
            console.error(exception);
            return;
        }
    }

    // Name is not used but is required by DM
    initializeClientState(_name: string, value: string): void {
        console.log("- Setting client state");
        try {
            this.clientState = JSON.parse(decodeURIComponent(value));
            this.clientState.browser.isReady = 1;
            this.clientState.hasChanged = 1;
            if (this.clientState.tickLag) {
                manager.tickLoop.start(this.clientState.tickLag);
            } else {
                throw Error(
                    "Was unable to start the network tick process because no tickLag was defined in this.clientState.tickLag.",
                );
            }
        } catch (exception) {
            console.error(exception);
            return;
        }
    }

    // Name is not used but is required by DM
    reflectClientState(): void {
        console.log("- Reflecting client state");
        try {
            const clientStateToSend = encodeURIComponent(JSON.stringify(this.clientState));
            BYOND.command(`setClientState ${clientStateToSend}`);
        } catch (exception) {
            console.error(exception);
            return;
        }
    }

    sendEvent(eventName: string): void {
        const event = {
            browserViewId: this.clientState.browser.windowId,
            name: eventName,
        };

        const eventToSend = JSON.stringify(event);

        console.log(eventName, eventToSend);

        BYOND.command(`captureEvent ${eventToSend}`);
    }
}
