// This is inserted automatically so we can set isReady for this component
// when the BYOND object is available.

// <INSERT_BROWSER_VIEW_ID>
// <INSERT_WINDOW_NAME>
// <INSERT_CONTROL_ID>

// When the BYOND object exists, this component is ready
window.addEventListener("byond-ready", waitForByond);

// If BYOND already exists, move along
if (BYOND) {
    window.removeEventListener("byond-ready", waitForByond);
    waitForByond();
}

function waitForByond() {
    // Note to self. Console logs will not work here
    // Logs aren't available yet, they get handled in required scripts which is next

    // This tells Dm the browser is totally loaded and ready for all scenarios
    BYOND.command(`setBrowserViewIsReady ${window.view.state.browserViewId}`);
}
