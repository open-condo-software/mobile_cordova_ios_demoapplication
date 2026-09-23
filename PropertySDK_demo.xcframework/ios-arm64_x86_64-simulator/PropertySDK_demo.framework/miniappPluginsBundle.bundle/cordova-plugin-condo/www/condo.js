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
    exports.withPromises = {};
    
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
    
    exports.hostApplication.identifier = function () {
        return __condoAppIdentifier || 'unknown';
    };
    
    exports.hostApplication.platform = function () {
        return __condoAppPlatform || "iOS";
    };
    
    /**
     * Launches a VoIP call with the specified configuration.
     *
     * @param {Object} params - VoIP configuration object
     * @param {string} params.voipAddress - Server address or destination endpoint
     * @param {string} params.voipLogin - Authentication login/username
     * @param {string} params.voipPassword - Authentication password
     * @param {Array<Object>} [params.voipPanels] - DTMF commands (optional)
     * @param {string} params.voipPanels[].name - name of the pannel (optional)
     * @param {string} params.voipPanels[].type = "door" - type of panel (optional)
     * @param {string} params.voipPanels[].dtmfCommand - command to call via dtmf (optional)
     * @param {string} params.voipPanels[].sendDTMFUrl - command to send POST to (optional)
     * @param {boolean} [params.autoAnswerCall=true] - Whether to automatically answer incoming calls
     * @param {Array<Object>} [params.iceServers] - Optional TURN, STUN or TURNS server configuration array
     * @param {string} params.iceServers[].address - server address
     * @param {string} params.iceServers[].login - server login (optional)
     * @param {string} params.iceServers[].password - server password (optional)
     * @param {function} success - Success callback
     * @param {function} error - Error callback
     *
     * @example
     * // Launch VoIP call with minimal configuration
     * launchVoIP(
     *   {
     *     voipAddress: 'some.sip.endpoint.com',
     *     voipLogin: 'john_doe',,
     *     voipPassword: 'secure123'
     *   },
     *   () => console.log('Call launched successfully'),
     *   (err) => console.error('Failed to launch call:', err),* );
     *
     * @example
     * // Full configuration with TURN servers and auto-answer disabled
     * launchVoIP(
     *   {
     *     voipAddress: 'some.sip.endpoint.com',
     *     voipLogin: 'employee',
     *     voipPassword: 'workpass',
     *     voipPanels: [{ name: "Door", type: "door", dtmfCommand: "#1" }],
     *     autoAnswerCall: false,
     *     iceServers: [
     *       {
     *         address: 'turn:turn1.company.com:3478',
     *         login: 'turn_user',
     *         password: 'turn_pass'
     *       },
     *       {
     *         address: 'stun:stun1.company.com:3478'
     *       },
     *       {
     *         address: 'turns:turn2.company.com:3478',
     *         login: 'turn_user2',
     *         password: 'turn_pass2'
     *       }
     *     ]
     *   },
     *   () => console.log('Call launched'),
     *   (err) => console.error('Error:', err),
     * );
     */
    exports.launchVoIP = function () {
        const args = Array.prototype.slice.call(arguments);
        
        const success = args[args.length - 2];
        const error = args[args.length - 1];
        
        let params = args.slice(0, -2);
        
        exec(success, error, 'Condo', 'launchVoIP', params);
    };
    
    exports.closeVoIP = function (success, error) {
        exec(success, error, 'Condo', 'closeVoIP', []);
    };

    //Payments
    exports.startMultiPayment = function (multiPaymentID, success, error) {
        exec(success, error, 'Condo', 'miniappStartMultiPayment', [multiPaymentID]);
    };
    
    exports.withPromises.startMultiPayment = function (multiPaymentID) {
        return new Promise((resolve, reject) => {
            exec(resolve, reject, 'Condo', 'miniappStartMultiPayment', [multiPaymentID]);
        });
    };
    
    exports.startInvoicePayment = function (invoiceID, success, error) {
        exec(success, error, 'Condo', 'miniappStartInvoicePayment', [invoiceID]);
    };

    exports.withPromises.startInvoicePayment = function (invoiceID) {
        return new Promise((resolve, reject) => {
            exec(resolve, reject, 'Condo', 'miniappStartInvoicePayment', [invoiceID]);
        });
    };

    //debug
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
    
    exports.startOidcAuth = function(url, success, error) {
        exec(success, error, 'Condo', 'startOidcAuth', [url]);
    }

    exports.withPromises.startOidcAuth = function(url) {
        return new Promise((resolve, reject) => {
            exec(resolve, reject, 'Condo', 'startOidcAuth', [url]);
        });
    }
});
