import { manager } from "..";
import { ClientStateJson } from "./JsonTypes/ClientStateJson";
import { GameStateJson } from "./JsonTypes/GameState";

export class StateManager {
    gameState: GameStateJson = {
        player: null,
        map: null,
        globalSettings: null,
    };

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
    initializeClientState(name: string, value: string): void {
        if (!this.initialized && name === "clientState") {
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

            console.log("- Client state successfully initialized");
            this.initialized = true;
        } else {
            // This might happen once or possibly twice, due to latency, but it shouldn't happen more than that.
            console.log("- Server attempted to initialize client state but it had already initialized");
        }
    }

    // Name is not used but is required by DM
    reflectClientState(): void {
        console.log("- Reflecting client state back to DM");

        const clientStateToSend = encodeURIComponent(JSON.stringify(this.clientState));

        // Using topic because client might grow to be fairly large
        BYOND.topic({
            viewEvent: "setClientState",
            value: clientStateToSend,
        });
    }

    updateMapState(name: string, value: string): void {
        if (name === "MapState") {
            console.log("- Updating game state");
            this.gameState.map = JSON.parse(decodeURIComponent(value));
            this.initialized = true;
        }
    }

    updatePlayerState(name: string, value: string): void {
        if (name === "PlayerState") {
            console.log("- Updating player state");
            this.gameState.player = JSON.parse(decodeURIComponent(value));
            this.initialized = true;
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
