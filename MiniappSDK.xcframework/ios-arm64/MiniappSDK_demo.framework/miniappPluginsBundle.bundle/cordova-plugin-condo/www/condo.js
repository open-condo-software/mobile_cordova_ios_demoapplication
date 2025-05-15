cordova.define("cordova-plugin-condo.Condo", function (require, exports, module) {
    var exec = require('cordova/exec');

    exports.requestAuthorizationCode = function (arg0, success, error) {
        exec(success, error, 'Condo', 'requestAuthorizationCode', [arg0]);
    };

    exports.requestAuthorization = function (arg0, arg1, success, error) {
        exec(success, error, 'Condo', 'requestAuthorization', [arg0, arg1]);
    };

    exports.closeApplication = function (success, error) {
        exec(success, error, 'Condo', 'closeApplication', []);
    };

    exports.requestServerAuthorization = function (arg0, arg1, arg2, success, error) {
        exec(success, error, 'Condo', 'requestServerAuthorization', [arg0, arg1, arg2]);
    };

    exports.requestServerAuthorizationByUrl = function (arg0, arg1, success, error) {
        exec(success, error, 'Condo', 'requestServerAuthorizationByUrl', [arg0, arg1]);
    };

    exports.getCurrentResident = function (success, error) {
        exec(success, error, 'Condo', 'getCurrentResident', []);
    };

    exports.getLaunchContext = function (success, error) {
        exec(success, error, 'Condo', 'getLaunchContext', []);
    };

    exports.notifyCallEnded = function (success, error) {
        exec(success, error, 'Condo', 'notifyCallEnded', []);
    };

    exports.setInputsEnabled = function (arg0, success, error) {
        exec(success, error, 'Condo', 'setInputsEnabled', [arg0]);
    };

    //Moved into private CDVWebViewEnginePlugin
    //exports.privateStoreSet
    //exports.privateStoreRemove
    //exports.privateStoreClear

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
        return __condoHostApplicationIsDemo || false;
    };

    exports.hostApplication.baseURL = function () {
        return __condoHostApplicationBaseURL || 'production_replace_it';
    }

    exports.hostApplication.installationID = function () {
        return __condoHostApplicationInstallationID || '';
    };

    exports.hostApplication.deviceID = function () {
        return __condoHostApplicationDeviceID || '';
    };

    exports.hostApplication.locale = function () {
        return __condoHostApplicationLocale || 'ru-RU';
    };

    exports.launchVoIP = function (type, address, login, password, dtmfCommand, stun, codec, autoAnswerCall, success, error) {
        exec(success, error, 'Condo', 'launchVoIP', [type, address, login, password, dtmfCommand, stun, codec, autoAnswerCall]);
    };

    exports.closeVoIP = function (success, error) {
        exec(success, error, 'Condo', 'closeVoIP', []);
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
    
    ///`startURLPattern` and `failURLPattern` support * and ? symbols as common wildecards.
    ///Example: "https://www.paywall.*/*/payment/*/success/"
    ///failURLPattern is optional
    exports.startSecureOauthPayment = function(url, successURLPattern, failURLPattern, success, error) {
        exec(success, error, 'Condo', 'startSecureOauthPayment', [url, successURLPattern, failURLPattern]);
    }
    
    exports.withPromises.startSecureOauthPayment = function(url, successURLPattern, failURLPattern) {
        return new Promise((resolve, reject) => {
            exec(resolve, reject, 'Condo', 'startSecureOauthPayment', [url, successURLPattern, failURLPattern]);
        });
    }
});
