import { BrowserView } from "../BrowserView/BrowserView";
import { Map } from "../I3D/Renderer/Map";

export {};

declare global {
    interface Window {
        view: BrowserView;
        map: Map;
    }
}
