import { StateManager } from "../State/StateManager";
import { I3DManager } from "..";

export {};

declare global {
    interface Window {
        view: StateManager;
        i3d: I3DManager;
    }
}
