import { StateManager } from "../BrowserView/BrowserView";
import { I3DManager } from "..";

export {};

declare global {
    interface Window {
        view: StateManager;
        i3d: I3DManager;
    }
}
