//
//  MiniappSDK-umbrella.h
//  MiniappSDK
//
//  Created by Alexandr Sivash on 13.11.2024.
//

#if DEMO
    #import <MiniappSDK_demo-Swift.h>
#else
    #import <MiniappSDK-Swift.h>
#endif

/* Intructions:
    1) remove everything below ~30 line
    2) Build
    3) Copy contents of MiniappSDK-Swift.h below with full replace like it was below line ~25 (dont forget the @imports) */
//  4) Replace all `@objc public /*public*/` into `@objc /*public*/`
/*      4.1) undo replace for the line above
    5) Compile again
    6) Praise the Absolute
    7) Build for export:
        cd mobile_ios_client
        sh MiniappSDK/MiniappSDK/Scripts/MakeXCFramework.sh client.xcworkspace MiniappSDK ~/Desktop/MiniappSDK
    8) Revert all changes back
*/

// Reverse imported declarations below


@import CoreBluetooth;
@import CoreLocation;
@import Foundation;
@import ObjectiveC;

@class MiniappID;
@class NSString;
@class CBPeripheralManager;
@class CLLocationManager;
SWIFT_CLASS("_TtC15MiniappSDK_demo15CBBeaconService")
@interface CBBeaconService : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) CBBeaconService * _Nonnull shared;)
+ (CBBeaconService * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
- (CBPeripheralManager * _Nonnull)dequeueReusablePeripheralManagerWithID:(MiniappID * _Nullable)miniappID options:(NSDictionary<NSString *, id> * _Nonnull)options SWIFT_WARN_UNUSED_RESULT;
- (CLLocationManager * _Nonnull)dequeueReusableLocationManagerWithID:(MiniappID * _Nullable)miniappID SWIFT_WARN_UNUSED_RESULT;
@end

@interface CBBeaconService (SWIFT_EXTENSION(MiniappSDK_demo)) <CBPeripheralManagerDelegate>
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager * _Nonnull)peripheral;
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager * _Nonnull)peripheral error:(NSError * _Nullable)error;
@end

@class CLRegion;
@class CLBeacon;
@class CLBeaconIdentityConstraint;
@class CLBeaconRegion;
@interface CBBeaconService (SWIFT_EXTENSION(MiniappSDK_demo)) <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager * _Nonnull)manager didStartMonitoringForRegion:(CLRegion * _Nonnull)region;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didRangeBeacons:(NSArray<CLBeacon *> * _Nonnull)beacons satisfyingConstraint:(CLBeaconIdentityConstraint * _Nonnull)beaconConstraint;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didEnterRegion:(CLRegion * _Nonnull)region;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didRangeBeacons:(NSArray<CLBeacon *> * _Nonnull)beacons inRegion:(CLBeaconRegion * _Nonnull)region;
@end

@class CBCentralManager;
SWIFT_CLASS("_TtC15MiniappSDK_demo16CBCentralService")
@interface CBCentralService : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) CBCentralService * _Nonnull shared;)
+ (CBCentralService * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
- (CBCentralManager * _Nonnull)dequeueReusableManagerWithID:(NSString * _Nullable)restorationID options:(NSDictionary<NSString *, id> * _Nonnull)options SWIFT_WARN_UNUSED_RESULT;
- (BOOL)doesMiniappSupportsBluetoothBackgroundFeatureWithMiniappID:(MiniappID * _Nonnull)miniappID SWIFT_WARN_UNUSED_RESULT;
@end

@class CBUUID;
@interface CBCentralService (SWIFT_EXTENSION(MiniappSDK_demo))
+ (void)registerServicesWithServices:(NSArray<CBUUID *> * _Nonnull)services uniqueID:(NSString * _Nonnull)uniqueID;
/// \param uniqueID is a string in format: <code>[address, miniappID].joined(separator: "|")</code>
///
+ (void)removeServicesWithUniqueID:(NSString * _Nonnull)uniqueID;
@end

@interface CBCentralService (SWIFT_EXTENSION(MiniappSDK_demo)) <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager * _Nonnull)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didRangeBeacons:(NSArray<CLBeacon *> * _Nonnull)beacons satisfyingConstraint:(CLBeaconIdentityConstraint * _Nonnull)beaconConstraint;
@end

@class CBPeripheral;
@class NSNumber;
@interface CBCentralService (SWIFT_EXTENSION(MiniappSDK_demo)) <CBCentralManagerDelegate>
- (void)centralManagerDidUpdateState:(CBCentralManager * _Nonnull)central;
- (void)centralManager:(CBCentralManager * _Nonnull)central willRestoreState:(NSDictionary<NSString *, id> * _Nonnull)dict;
- (void)centralManager:(CBCentralManager * _Nonnull)central didDiscoverPeripheral:(CBPeripheral * _Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> * _Nonnull)advertisementData RSSI:(NSNumber * _Nonnull)RSSI;
@end

SWIFT_CLASS("_TtC15MiniappSDK_demo19CBPeripheralService")
@interface CBPeripheralService : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) CBPeripheralService * _Nonnull shared;)
+ (CBPeripheralService * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
- (CBPeripheralManager * _Nonnull)dequeueReusableManagerWithID:(MiniappID * _Nullable)miniappID options:(NSDictionary<NSString *, id> * _Nonnull)options SWIFT_WARN_UNUSED_RESULT;
- (void)startSendingStashedReadWriteEventsWithMiniappID:(MiniappID * _Nonnull)miniappID;
- (NSDictionary<NSString *, id> * _Nonnull)getBluetoothSystemStateWithMiniappID:(MiniappID * _Nonnull)miniappID SWIFT_WARN_UNUSED_RESULT;
- (BOOL)doesMiniappSupportsBluetoothBackgroundFeatureWithMiniappID:(MiniappID * _Nonnull)miniappID SWIFT_WARN_UNUSED_RESULT;
@end

@class CBService;
@class CBATTRequest;
@class CBL2CAPChannel;
@interface CBPeripheralService (SWIFT_EXTENSION(MiniappSDK_demo)) <CBPeripheralManagerDelegate>
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager * _Nonnull)peripheral;
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager * _Nonnull)peripheral error:(NSError * _Nullable)error;
- (void)peripheralManager:(CBPeripheralManager * _Nonnull)peripheral didAddService:(CBService * _Nonnull)service error:(NSError * _Nullable)error;
- (void)peripheralManager:(CBPeripheralManager * _Nonnull)peripheral didReceiveReadRequest:(CBATTRequest * _Nonnull)request;
- (void)peripheralManager:(CBPeripheralManager * _Nonnull)peripheral didReceiveWriteRequests:(NSArray<CBATTRequest *> * _Nonnull)requests;
- (void)peripheralManager:(CBPeripheralManager * _Nonnull)peripheral didOpenL2CAPChannel:(CBL2CAPChannel * _Nullable)channel error:(NSError * _Nullable)error;
- (void)peripheralManager:(CBPeripheralManager * _Nonnull)peripheral didPublishL2CAPChannel:(CBL2CAPPSM)PSM error:(NSError * _Nullable)error;
@end

SWIFT_CLASS("_TtC15MiniappSDK_demo23DYLDStartServiceInterop")
@interface DYLDStartServiceInterop : NSObject
+ (void)dyld_start;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIViewController;
SWIFT_CLASS("_TtC15MiniappSDK_demo35MiniappCordovaViewControllerInterop")
@interface MiniappCordovaViewControllerInterop : NSObject
- (nonnull instancetype)initWithController:(UIViewController * _Nonnull)controller OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly, copy) NSString * _Nullable context;
@property (nonatomic, readonly, strong) MiniappID * _Nonnull miniappID;
- (void)didPressBackButton;
- (void)pushStateWithState:(id _Nonnull)state title:(NSString * _Nonnull)title;
- (void)replaceStateWithState:(id _Nonnull)state title:(NSString * _Nonnull)title;
- (NSString * _Nullable)goTo:(NSInteger)delta SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nullable)back SWIFT_WARN_UNUSED_RESULT;
- (void)currentResidentWithCompletion:(void (^ _Nonnull)(NSDictionary * _Nullable))completion;
- (void)setTextInteractionEnabledWithEnabled:(BOOL)enabled;
- (void)miniappStartInvoicePaymentWithInvoiceID:(NSString * _Nonnull)invoiceID completion:(void (^ _Nonnull)(NSString * _Nonnull, NSString * _Nullable, NSString * _Nonnull))completion;
- (void)miniappStartOauthPaymentWithUrl:(NSString * _Nonnull)url successURLPattern:(NSString * _Nonnull)successURLPattern failUrlPattern:(NSString * _Nullable)failUrlPattern completion:(void (^ _Nonnull)(NSDictionary<NSString *, NSString *> * _Nonnull))completion;
- (BOOL)endCurrentCall SWIFT_WARN_UNUSED_RESULT;
- (BOOL)endAllCalls SWIFT_WARN_UNUSED_RESULT;
- (BOOL)initiateVoipWithType:(NSString * _Nonnull)type address:(NSString * _Nonnull)address login:(NSString * _Nonnull)login password:(NSString * _Nonnull)password dtmfCommand:(NSString * _Nullable)dtmfCommand stun:(NSString * _Nullable)stun preferredCodec:(NSString * _Nullable)preferredCodec autoAnswerCall:(BOOL)autoAnswerCall SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

/// Структура(в objc нельзя структуры, теперь это класс), унифицирующая работу с идентификацией миниаппов во всех доменах миниаппов, от CBCentral до MiniappClientService
SWIFT_CLASS("_TtC15MiniappSDK_demo9MiniappID")
@interface MiniappID : NSObject
- (nonnull instancetype)initWithAppID:(NSString * _Nonnull)appID residentID:(NSString * _Nonnull)residentID OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithRawValue:(NSString * _Nonnull)rawValue OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly) NSUInteger hash;
@property (nonatomic, readonly, copy) NSString * _Nonnull rawValue;
- (BOOL)isEqual:(id _Nullable)object SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

SWIFT_CLASS("_TtC15MiniappSDK_demo20MiniappLaunchService")
@interface MiniappLaunchService : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) MiniappLaunchService * _Nonnull shared;)
+ (MiniappLaunchService * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
- (void)closeCurrentMiniappWithMiniappID:(MiniappID * _Nonnull)miniappID;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@interface MiniappLaunchService (SWIFT_EXTENSION(MiniappSDK_demo))
- (void)serverAuthByClientId:(NSString * _Nonnull)byClientId serverURI:(NSString * _Nonnull)serverURI miniappID:(MiniappID * _Nonnull)miniappID completion:(void (^ _Nonnull)(NSString * _Nullable))completion;
- (void)serverAuthByURL:(NSString * _Nonnull)byURL miniappID:(MiniappID * _Nonnull)miniappID params:(NSDictionary<NSString *, id> * _Nonnull)params completion:(void (^ _Nonnull)(NSDictionary<NSString *, id> * _Nullable))completion;
@end

@interface MiniappLaunchService (SWIFT_EXTENSION(MiniappSDK_demo))
- (void)setMiniappDebugLoggingEnabledWithMiniappID:(MiniappID * _Nonnull)miniappID enabled:(BOOL)enabled;
- (void)setEventNameRegisteredForLocalNotificationPrintingWithMiniappID:(MiniappID * _Nonnull)miniappID eventName:(NSString * _Nonnull)eventName enabled:(BOOL)enabled;
- (void)publicLogPrintWithMiniappID:(MiniappID * _Nullable)miniappID identifier:(NSString * _Nonnull)identifier text:(NSString * _Nonnull)text;
@end
