import { BrowserJson } from "./BrowserJson";

export type ClientStateJson = {
    browser: BrowserJson;
    tickLag: number | null;
    hasChanged: number | null;
};
