/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

// Wait for the deviceready event before using any of Cordova's device APIs.
// See https://cordova.apache.org/docs/en/latest/cordova/events/events.html#deviceready


// import UserManager from './oidc-client-ts/index';
// import 'oidc-client-ts.min.js';
// import * as Oidc from './oidc-client-ts.min.js';

document.addEventListener('deviceready', onDeviceReady, false);


function closeApplication() {
    cordova.plugins.condo.closeApplication(function (response) { }, function (error) { })
}

function onDeviceReady() {
    // Cordova is now initialized. Have fun!

    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);

    document.getElementById('deviceready').classList.add('ready');

    cordova.plugins.condo.getLaunchContext(function (response) {
        console.log("cordova.plugins.condo.getLaunchContext() response => ", response);
    }, function (error) {
        console.log(error);
    })


    var uuid = 'B9407F30-F5F8-466E-AFF9-25556B57FE6D';
    var identifier = 'advertisedBeacon';
    var minor = 2000;
    var major = 5;
    var beaconRegion = new cordova.plugins.locationManager.BeaconRegion(identifier, uuid, major, minor);

    // The Delegate is optional
    var delegate = new cordova.plugins.locationManager.Delegate();

    // Event when advertising starts (there may be a short delay after the request)
    // The property 'region' provides details of the broadcasting Beacon
    delegate.peripheralManagerDidStartAdvertising = function (pluginResult) {
        console.log('peripheralManagerDidStartAdvertising: ' + JSON.stringify(pluginResult.region));
    };
    // Event when bluetooth transmission state changes 
    // If 'state' is not set to BluetoothManagerStatePoweredOn when advertising cannot start
    delegate.peripheralManagerDidUpdateState = function (pluginResult) {
        console.log('peripheralManagerDidUpdateState: ' + pluginResult.state);
    };

    cordova.plugins.locationManager.setDelegate(delegate);

    // Verify the platform supports transmitting as a beacon
    cordova.plugins.locationManager.isAdvertisingAvailable()
        .then(function (isSupported) {

            if (isSupported) {
                cordova.plugins.locationManager.startAdvertising(beaconRegion)
                    .fail(console.error)
                    .done();
            } else {
                console.log("Advertising not supported");
            }
        })
        .fail(function (e) { console.error(e); })
        .done();


    const clientId = 'miniapp-mobile-test-web';

    // DOMA!
    // Вариант авторизации номер один
    // У нас нет сервера и мы просим приложение авторизовать нас на кондо:
    // 1) запрашиваем у основного приложения авторизацию по клиент айди и секрет и получаем токен и рефреш токен
    // 2) при необходимости просим обновить
    // const clientSecret = 'V3KQHSjCYR6P9zPQxEYc8KWwfi9XNVmn';
    // cordova.plugins.condo.requestAuthorization(clientId, clientSecret, function(response) {
    //     console.log(response);
    //     console.log('recive responce result => ', response);
    // }, function(error) {
    //     console.log(error);
    // })

    // DOMA!
    // Вариант авторизации номер два - основной способ, мы обращаемся на сервер миниапа и просим авторизовать, а дльше редиректы по всему сценарию


    let data = { "variables": {}, "query": "{\n  authenticatedUser {\n    id\n    name\n   email\n    isAdmin\n    __typename\n  }\n}\n" };

    // request options
    const options = {
        method: 'POST',
        body: JSON.stringify(data),
        credentials: "include",
        headers: {
            'Content-Type': 'application/json'
        }
    }

    // send post request
    fetch('https://miniapp.d.doma.ai/admin/api', options)
        .then(res => res.json())
        .then((res) => {
            if (res.data.authenticatedUser) {
                console.log('authentificated => ', JSON.stringify(res.data.authenticatedUser));
                cordova.plugins.condo.getCurrentResident(function (response) {
                    console.log("current resident\address => ", JSON.stringify(response));
                }, function (error) {
                    console.log(error);
                })
            } else {
                console.log('authentification missing => ', JSON.stringify(res));
                // вот она
                cordova.plugins.condo.requestServerAuthorizationByUrl('https://miniapp.d.doma.ai/oidc/auth', {}, function (response) {
                    console.log(response);
                    console.log('recive authorication result => ', JSON.stringify(response));
                    console.log('reloading');
                    window.location.reload();
                }, function (error) {
                    console.log(error);
                });
            }
        })
        .catch(err => console.error(err));

    document.getElementById("CloseButton").addEventListener("click", closeApplication);

}
