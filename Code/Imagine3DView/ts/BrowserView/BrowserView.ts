import { MapJson } from "../JsonTypes/JsonMap";

export class BrowserView {
    state: {
        [key: string]: any;
    } = {};

    constructor() {
        console.log("BrowserView");
        console.log("- Successfully created");
        console.log("- Listening for state changes");
    }

    setState(name: string, value: string) {
        // console.log("BrowserView (setState)");
        // console.log("State recieved [name]", name);
        // console.log("State recieved [value]", JSON.stringify(value));

        const originalState = JSON.stringify(this.state);
        try {
            this.state[name] = JSON.parse(decodeURIComponent(value));
        } catch (exception) {
            console.error(exception);
            return;
        }

        const newState = JSON.stringify(this.state);

        // Don't send updates if nothing changed
        if (newState != originalState) {
            //console.log("- Synchronizing with DM, sending current state back", name);

            const stateToSend = encodeURIComponent(JSON.stringify(this.state));

            BYOND.topic({
                viewEvent: "reflectState",
                value: stateToSend,
            });
        }

        // console.log("State update completed", name);
    }

    sendEvent(eventName: string) {
        const event = {
            browserViewId: this.state.browserViewId,
            name: eventName,
        };

        const eventToSend = JSON.stringify(event);

        console.log(eventName, eventToSend);

        BYOND.command(`captureEvent ${eventToSend}`);
    }
}

export const view = new BrowserView();

//
window.view = view;
