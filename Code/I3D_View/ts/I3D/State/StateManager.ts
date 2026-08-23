import { manager } from "..";
import { ClientStateJson } from "./JsonTypes/ClientStateJson";

export class StateManager {
    gameState: {
        [key: string]: any;
    } = {};

    clientState: ClientStateJson = {
        browser: {
            windowId: null,
            controlId: null,
            isReady: null,
            tickLag: null,
            hasChanged: 0,
        },
    };

    initialized = false;

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
        if (!this.initialized) {
            try {
                console.log("- Initailizing client state");

                this.clientState = JSON.parse(decodeURIComponent(value));
                this.clientState.browser.isReady = 1;
                this.clientState.browser.hasChanged = 1;

                if (this.clientState.browser.tickLag) {
                    manager.tickLoop.start(this.clientState.browser.tickLag);
                } else {
                    throw Error(
                        "Was unable to start the network tick process because no tickLag was defined in this.clientState.tickLag.",
                    );
                }
            } catch (exception) {
                console.error(exception);
                return;
            }
            console.log("- Client state successfully initialized");
            this.initialized = true;
        } else {
            // This might happen once or possibly twice, due to latency, but it shouldn't happen more than that.
            console.log("- Server attempted to initialize client state but it had already initialized");
        }
    }

    // Name is not used but is required by DM
    reflectClientState(): void {
        console.log("- Reflecting client state");
        try {
            const clientStateToSend = encodeURIComponent(JSON.stringify(this.clientState));
            console.log("- Sending client state: ", JSON.stringify(this.clientState));
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
// // Don't send updates if nothing changed
// if (newState != originalState) {
//     //console.log("- Synchronizing with DM, sending current state back", name);

//     const stateToSend = encodeURIComponent(JSON.stringify(this.state));

//     BYOND.topic({
//         viewEvent: "reflectState",
//         value: stateToSend,
//     });
// }
