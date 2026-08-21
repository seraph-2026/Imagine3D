import { BrowserView } from "../BrowserView/BrowserView";
import { Map } from "../Renderer/Map";

export {};

declare global {
    interface Window {
        view: BrowserView;
        map: Map;
    }
}
