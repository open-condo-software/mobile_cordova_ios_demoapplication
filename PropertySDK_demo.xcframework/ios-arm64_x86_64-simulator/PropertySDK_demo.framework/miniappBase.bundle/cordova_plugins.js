cordova.define('cordova/plugin_list', function (require, exports, module) {

  const potentialPlugins = [
      {
        "id": "cordova-plugin-condo.Condo",
        "file": "plugins/cordova-plugin-condo/www/condo.js",
        "pluginId": "cordova-plugin-condo",
        "clobbers": [
          "cordova.plugins.condo"
        ]
      },
      {
        "id": "cordova-plugin-ble-peripheral.blePeripheral",
        "file": "plugins/cordova-plugin-ble-peripheral/www/blePeripheral.js",
        "pluginId": "cordova-plugin-ble-peripheral",
        "clobbers": [
          "blePeripheral"
        ]
      },
      {
        "id": "cordova-plugin-file.DirectoryEntry",
        "file": "plugins/cordova-plugin-file/www/DirectoryEntry.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.DirectoryEntry"
        ]
      },
      {
        "id": "cordova-plugin-file.DirectoryReader",
        "file": "plugins/cordova-plugin-file/www/DirectoryReader.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.DirectoryReader"
        ]
      },
      {
        "id": "cordova-plugin-file.Entry",
        "file": "plugins/cordova-plugin-file/www/Entry.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.Entry"
        ]
      },
      {
        "id": "cordova-plugin-file.File",
        "file": "plugins/cordova-plugin-file/www/File.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.File"
        ]
      },
      {
        "id": "cordova-plugin-file.FileEntry",
        "file": "plugins/cordova-plugin-file/www/FileEntry.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.FileEntry"
        ]
      },
      {
        "id": "cordova-plugin-file.FileError",
        "file": "plugins/cordova-plugin-file/www/FileError.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.FileError"
        ]
      },
      {
        "id": "cordova-plugin-file.FileReader",
        "file": "plugins/cordova-plugin-file/www/FileReader.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.FileReader"
        ]
      },
      {
        "id": "cordova-plugin-file.FileSystem",
        "file": "plugins/cordova-plugin-file/www/FileSystem.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.FileSystem"
        ]
      },
      {
        "id": "cordova-plugin-file.FileUploadOptions",
        "file": "plugins/cordova-plugin-file/www/FileUploadOptions.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.FileUploadOptions"
        ]
      },
      {
        "id": "cordova-plugin-file.FileUploadResult",
        "file": "plugins/cordova-plugin-file/www/FileUploadResult.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.FileUploadResult"
        ]
      },
      {
        "id": "cordova-plugin-file.FileWriter",
        "file": "plugins/cordova-plugin-file/www/FileWriter.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.FileWriter"
        ]
      },
      {
        "id": "cordova-plugin-file.Flags",
        "file": "plugins/cordova-plugin-file/www/Flags.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.Flags"
        ]
      },
      {
        "id": "cordova-plugin-file.LocalFileSystem",
        "file": "plugins/cordova-plugin-file/www/LocalFileSystem.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.LocalFileSystem"
        ],
        "merges": [
          "window"
        ]
      },
      {
        "id": "cordova-plugin-file.Metadata",
        "file": "plugins/cordova-plugin-file/www/Metadata.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.Metadata"
        ]
      },
      {
        "id": "cordova-plugin-file.ProgressEvent",
        "file": "plugins/cordova-plugin-file/www/ProgressEvent.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.ProgressEvent"
        ]
      },
      {
        "id": "cordova-plugin-file.fileSystems",
        "file": "plugins/cordova-plugin-file/www/fileSystems.js",
        "pluginId": "cordova-plugin-file"
      },
      {
        "id": "cordova-plugin-file.requestFileSystem",
        "file": "plugins/cordova-plugin-file/www/requestFileSystem.js",
        "pluginId": "cordova-plugin-file",
        "clobbers": [
          "window.requestFileSystem"
        ]
      },
      {
        "id": "cordova-plugin-file.resolveLocalFileSystemURI",
        "file": "plugins/cordova-plugin-file/www/resolveLocalFileSystemURI.js",
        "pluginId": "cordova-plugin-file",
        "merges": [
          "window"
        ]
      },
      {
        "id": "cordova-plugin-file.isChrome",
        "file": "plugins/cordova-plugin-file/www/browser/isChrome.js",
        "pluginId": "cordova-plugin-file",
        "runs": true
      },
      {
        "id": "cordova-plugin-file.iosFileSystem",
        "file": "plugins/cordova-plugin-file/www/ios/FileSystem.js",
        "pluginId": "cordova-plugin-file",
        "merges": [
          "FileSystem"
        ]
      },
      {
        "id": "cordova-plugin-file.fileSystems-roots",
        "file": "plugins/cordova-plugin-file/www/fileSystems-roots.js",
        "pluginId": "cordova-plugin-file",
        "runs": true
      },
      {
        "id": "cordova-plugin-file.fileSystemPaths",
        "file": "plugins/cordova-plugin-file/www/fileSystemPaths.js",
        "pluginId": "cordova-plugin-file",
        "merges": [
          "cordova"
        ],
        "runs": true
      },
      {
        "id": "cordova-plugin-media-capture.CaptureAudioOptions",
        "file": "plugins/cordova-plugin-media-capture/www/CaptureAudioOptions.js",
        "pluginId": "cordova-plugin-media-capture",
        "clobbers": [
          "CaptureAudioOptions"
        ]
      },
      {
        "id": "cordova-plugin-media-capture.CaptureImageOptions",
        "file": "plugins/cordova-plugin-media-capture/www/CaptureImageOptions.js",
        "pluginId": "cordova-plugin-media-capture",
        "clobbers": [
          "CaptureImageOptions"
        ]
      },
      {
        "id": "cordova-plugin-media-capture.CaptureVideoOptions",
        "file": "plugins/cordova-plugin-media-capture/www/CaptureVideoOptions.js",
        "pluginId": "cordova-plugin-media-capture",
        "clobbers": [
          "CaptureVideoOptions"
        ]
      },
      {
        "id": "cordova-plugin-media-capture.CaptureError",
        "file": "plugins/cordova-plugin-media-capture/www/CaptureError.js",
        "pluginId": "cordova-plugin-media-capture",
        "clobbers": [
          "CaptureError"
        ]
      },
      {
        "id": "cordova-plugin-media-capture.MediaFileData",
        "file": "plugins/cordova-plugin-media-capture/www/MediaFileData.js",
        "pluginId": "cordova-plugin-media-capture",
        "clobbers": [
          "MediaFileData"
        ]
      },
      {
        "id": "cordova-plugin-media-capture.MediaFile",
        "file": "plugins/cordova-plugin-media-capture/www/MediaFile.js",
        "pluginId": "cordova-plugin-media-capture",
        "clobbers": [
          "MediaFile"
        ]
      },
      {
        "id": "cordova-plugin-media-capture.helpers",
        "file": "plugins/cordova-plugin-media-capture/www/helpers.js",
        "pluginId": "cordova-plugin-media-capture",
        "runs": true
      },
      {
        "id": "cordova-plugin-media-capture.capture",
        "file": "plugins/cordova-plugin-media-capture/www/capture.js",
        "pluginId": "cordova-plugin-media-capture",
        "clobbers": [
          "navigator.device.capture"
        ]
      },
      {
        "id": "cordova-plugin-network-information.network",
        "file": "plugins/cordova-plugin-network-information/www/network.js",
        "pluginId": "cordova-plugin-network-information",
        "clobbers": [
          "navigator.connection"
        ]
      },
      {
        "id": "cordova-plugin-network-information.Connection",
        "file": "plugins/cordova-plugin-network-information/www/Connection.js",
        "pluginId": "cordova-plugin-network-information",
        "clobbers": [
          "Connection"
        ]
      },
      {
        "id": "cordova-plugin-ble-central.ble",
        "file": "plugins/cordova-plugin-ble-central/www/ble.js",
        "pluginId": "cordova-plugin-ble-central",
        "clobbers": [
          "ble"
        ]
      },
      {
        "id": "cordova-plugin-device.device",
        "file": "plugins/cordova-plugin-device/www/device.js",
        "pluginId": "cordova-plugin-device",
        "clobbers": [
          "device"
        ]
      },
      {
        "id": "com.unarin.cordova.beacon.underscorejs",
        "file": "plugins/com.unarin.cordova.beacon/www/lib/underscore-min-1.6.js",
        "pluginId": "com.unarin.cordova.beacon",
        "runs": true
      },
      {
        "id": "com.unarin.cordova.beacon.Q",
        "file": "plugins/com.unarin.cordova.beacon/www/lib/q.min.js",
        "pluginId": "com.unarin.cordova.beacon",
        "runs": true
      },
      {
        "id": "com.unarin.cordova.beacon.LocationManager",
        "file": "plugins/com.unarin.cordova.beacon/www/LocationManager.js",
        "pluginId": "com.unarin.cordova.beacon",
        "merges": [
          "cordova.plugins"
        ]
      },
      {
        "id": "com.unarin.cordova.beacon.Delegate",
        "file": "plugins/com.unarin.cordova.beacon/www/Delegate.js",
        "pluginId": "com.unarin.cordova.beacon",
        "runs": true
      },
      {
        "id": "com.unarin.cordova.beacon.Region",
        "file": "plugins/com.unarin.cordova.beacon/www/model/Region.js",
        "pluginId": "com.unarin.cordova.beacon",
        "runs": true
      },
      {
        "id": "com.unarin.cordova.beacon.Regions",
        "file": "plugins/com.unarin.cordova.beacon/www/Regions.js",
        "pluginId": "com.unarin.cordova.beacon",
        "runs": true
      },
      {
        "id": "com.unarin.cordova.beacon.CircularRegion",
        "file": "plugins/com.unarin.cordova.beacon/www/model/CircularRegion.js",
        "pluginId": "com.unarin.cordova.beacon",
        "runs": true
      },
      {
        "id": "com.unarin.cordova.beacon.BeaconRegion",
        "file": "plugins/com.unarin.cordova.beacon/www/model/BeaconRegion.js",
        "pluginId": "com.unarin.cordova.beacon",
        "runs": true
      }
  ];

  var availablePlugins = [];

  function moduleIsAvailable(path) {
    var xhr = new XMLHttpRequest();
    xhr.open('HEAD', path, false);
    xhr.send();
    return xhr.status !== 404;
  }

  potentialPlugins.forEach(function (plugin) {
    console.log(plugin);
    console.log(plugin.file);
    // var file = new File(plugin.file);
    if (moduleIsAvailable(plugin.file)) {
      // if (file.exists) {
      availablePlugins.push(plugin);
    }
  });

  module.exports = availablePlugins;
  module.exports.metadata = {
      "cordova-plugin-whitelist": "1.3.5",
      "cordova-plugin-condo": "0.0.2",
      "cordova-plugin-ble-central": "1.5.0",
      "cordova-plugin-ble-peripheral": "1.1.2.2",
      "cordova-plugin-device": "2.1.0",
      "cordova-plugin-file": "8.1.0",
      "cordova-plugin-media-capture": "5.0.1-dev",
      "cordova-plugin-network-information": "3.0.0",
      "com.unarin.cordova.beacon": "3.8.1"
  };
});
