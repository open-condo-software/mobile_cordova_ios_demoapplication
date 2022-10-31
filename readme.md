# Hello! 

This is a Condo Miniapps playground for iOS, it is still under development, but already allows you to feel the real process of interaction with the application.

You can find the cordova app itself in the MainCordovaApplication folder, where in the www folder there is an example of interaction with the native api and you can develop something of your own.


___
# Content.
1. [Getting started](#getting_started)
2. [Common methods.](#common_methods)
3. [Testing.](#testing)
4. [Publishing.](#publishing)


---
# Getting started. <a name="getting_started"></a>

1. Installing the necessary dependencies:

    - make sure you have the latest version of the mac OS, Xcode and Xcode CLT installed

    - make sure that the desired Xcode CLTs are selected, this can be done in the Xcode settings: 

        Xcode -> Preferences -> Locations -> Command Line Tools

    - homebrew installation
    
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        then run the three commands suggested in the terminal to add homebrew to the environment variables

            echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"

    - cocoapods installation

            brew install cocoapods
        Note that the installation is not done in the recommended way, but through a third-party package manager. if you install any other way, you will get errors while working on modern hardware.

    - installing nvm, node and npm

        https://github.com/nvm-sh/nvm#installing-and-updating

    - cordova installation

            npm install -g cordova

2. Editing the application

    - open the project directory and go to the /MainCordovaApplication/www subdirectory
        
        it will contain your application code, edit it freely
    
    - after editing the code in the MainCordovaApplication directory, run the command

            cordova prepare ios
        this will prepare all your changes for launch
    
3. Launching and testing the application

    - in the main project directory, run the command

            pod install
        this command only needs to be executed once before the first run
    
    - in the main project directory, run the file CordovaDemoApp.xcworkspace. Pay attention to the extension.

    - after opening the project in Xcode, run it
            
            cmd + R

4. Optimizing
    
    So that you don't have to run the cordova prepare ios command in the terminal after each code change, you can set it to work automatically when you start the project in Xcode. To do this, do the following steps:

    - open the project in Xcode
    - in the project navigator tab (cmd + 1) select the topmost node named CordovaDemoApp, it will have a blue square icon with the App Store icon
    - select CordovaDemoApp in the TARGETS subsection
    - open the Build Phases tab
    - expand the 4th element in the list that opens called "Run Script"
    - add there a line by the example from the comment

            path/to/installed/cordova prepare ios 
        after that, each time you start the project, the corresponding command will be executed automatically.


 ---
# Common methods. <a name="common_methods"></a>
- authorization

    function requestServerAuthorizationByUrl(miniapp_server_init_auth_url, custom_params_reserver_for_future_use, success, error) 

    example:

            cordova.plugins.condo.requestServerAuthorizationByUrl('https://miniapp.d.doma.ai/oidc/auth', {}, function(response) {
                console.log('recive authorication result => ', JSON.stringify(response));
                window.location.reload();
            }, function(error) {
                console.log(error);
            });

- obtaining a current resident/address

    function getCurrentResident(success, error)

    example:

            cordova.plugins.condo.getCurrentResident(function(response) {
                console.log("current resident\address => ", JSON.stringify(response));
            }, function(error) {
                console.log(error);
            });

- application closing

    function closeApplication(success, error)

    example:

            cordova.plugins.condo.closeApplication(function(response) {}, function(error) {});


---
# Testing(as of November 1, 2022).  <a name="testing"></a>
1.  Open the project directory and navigate to the subdirectory 
        
        /MainCordovaApplication/platforms/ios/
    In it you will find the www directory.
    Create a zip archive from the www directory by right-clicking on the folder and selecting Compress "www".

2. Place the resulting archive in the iCloud storage of the account connected to the device on which you will be testing the application.

3. Install the Doma app from the AppStore and log in to it
    https://apps.apple.com/us/app/doma/id1573897686

4. The app you downloaded has built-in functionality for debugging mini-applications. To turn it on and off, you use links to open it on your device:
    
    - Switching on:
    
        ai.doma.client.service://miniapps/local/enable
    - Switching off:
                    
        ai.doma.client.service://miniapps/local/disable

5. Now, on the main application screen in the list of mini-applications, the last button allows you to download or replace a previously downloaded mini-application from files. When you click on it, you need to select the previously downloaded archive in iCloud.

6. The application loaded in this way has a built-in js console, which is accessible by clicking on the button at the bottom right of the open mini-application and is able to show a lot of additional information, including various errors.


---
# Publishing <a name="publishing"></a>
To publish the mini-application, send the archive you received during the testing phase to the people at Doma with whom you interact. 