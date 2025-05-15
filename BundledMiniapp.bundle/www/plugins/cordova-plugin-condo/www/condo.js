cordova.define("cordova-plugin-condo.Condo", function(require, exports, module) {
var exec = require('cordova/exec');

exports.requestAuthorization = function (arg0, arg1, success, error) {
    exec(success, error, 'Condo', 'requestAuthorization', [arg0, arg1]);
};

exports.requestServerAuthorizationByUrl = function (arg0, arg1, success, error) {
    exec(success, error, 'Condo', 'requestServerAuthorizationByUrl', [arg0, arg1]);
};

exports.openURLWithFallback = function (arg0, arg1, success, error) {
    exec(success, error, 'Condo', 'openURLWithFallback', [arg0, arg1]);
};

exports.closeApplication = function (success, error) {
    exec(success, error, 'Condo', 'closeApplication', []);
};

exports.getCurrentResident = function (success, error) {
    exec(success, error, 'Condo', 'getCurrentResident', []);
};

exports.getLaunchContext = function (success, error) {
    exec(success, error, 'Condo', 'getLaunchContext', []);
};

exports.setInputsEnabled = function (arg0, success, error) {
    exec(success, error, 'Condo', 'setInputsEnabled', [arg0]);
};

exports.history = {};

exports.history.back = function (success, error) {
    exec(success, error, 'Condo', 'historyBack', []);
};

exports.history.pushState = function (state, title, success, error) {
    exec(success, error, 'Condo', 'historyPushState', [state, title]);
};

exports.history.replaceState = function (state, title, success, error) {
    exec(success, error, 'Condo', 'historyReplaceState', [state, title]);
};

exports.history.go = function (amount, success, error) {
    exec(success, error, 'Condo', 'historyGo', [amount]);
};

exports.hostApplication = {};

exports.hostApplication.isDemoEnvironment = function () {
    return true;
}

exports.hostApplication.baseURL = function () {
    return 'https://condo.d.doma.ai';
}

exports.hostApplication.installationID = function () {
    return 'b8f73d1c-158a-4507-8b9d-379220c49e3b';
}

exports.hostApplication.deviceID = function () {
    return 'ff3654eb-033b-45a0-b7db-c519d70159ba';
}

exports.hostApplication.locale = function () {
    return 'ru-RU';
}

exports.launchVoIP = function (type, address, login, password, dtmfCommand, stun, codec, autoAnswerCall, success, error) {
    console.log('native VoIP screen is not implemented in demo. This will work in the real app.')
    //exec(success, error, 'Condo', 'launchVoIP', [type, address, login, password, dtmfCommand, stun, codec, autoAnswerCall]);
};

exports.closeVoIP = function (success, error) {
    console.log('native VoIP screen is not implemented in demo. This will work in the real app.')
    ///exec(success, error, 'Condo', 'closeVoIP', []);
};

exports.startInvoicePayment = function (invoiceID, success, error) {
    exec(success, error, 'Condo', 'miniappStartInvoicePayment', [invoiceID]);
};

exports.withPromises = {};
exports.withPromises.startInvoicePayment = function (invoiceID) {
    return new Promise((resolve, reject) => {
        exec(resolve, reject, 'Condo', 'miniappStartInvoicePayment', [invoiceID]);
    });
};

exports.debug = { };

exports.debug.setDebugLoggingEnabled = function(enabled) {
    exec(() => {}, () => {}, 'Condo', 'setMiniappDebugLoggingEnabled', [enabled]);
};

exports.debug.setEventNameRegisteredForLocalNotificationRepresentation = function(eventName, registered) {
    exec(() => {}, () => {}, 'Condo', 'setEventNameRegisteredForLocalNotificationRepresentation', [eventName, registered]);
};
    
});
