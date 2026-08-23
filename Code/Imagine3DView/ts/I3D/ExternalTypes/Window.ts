import { BrowserView } from "../BrowserView/BrowserView";
import { I3DManager } from "..";

export {};

declare global {
    interface Window {
        view: BrowserView;
        i3d: I3DManager;
    }
}
