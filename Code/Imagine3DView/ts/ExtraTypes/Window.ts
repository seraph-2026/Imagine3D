import { BrowserView } from "../BrowserView/BrowserView";
import { I3DManager } from "../I3D";

export {};

declare global {
    interface Window {
        view: BrowserView;
        i3d: I3DManager;
    }
}
