interface BYOND {
    command(command: string): void;
    topic(data: object): void;
    winset(control: string, options: object): void;
}

declare const BYOND: BYOND;
