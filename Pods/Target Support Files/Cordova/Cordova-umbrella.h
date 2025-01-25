#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CDV.h"
#import "CDVAllowList.h"
#import "CDVAppDelegate.h"
#import "CDVAvailability.h"
#import "CDVAvailabilityDeprecated.h"
#import "CDVCommandDelegate.h"
#import "CDVCommandQueue.h"
#import "CDVConfigParser.h"
#import "CDVInvokedUrlCommand.h"
#import "CDVPlugin+Resources.h"
#import "CDVPlugin.h"
#import "CDVPluginResult.h"
#import "CDVScreenOrientationDelegate.h"
#import "CDVTimer.h"
#import "CDVURLSchemeHandler.h"
#import "CDVViewController.h"
#import "CDVWebViewEngine.h"
#import "CDVWebViewEngineProtocol.h"
#import "CDVWebViewProcessPoolFactory.h"
#import "CDVWebViewUIDelegate.h"
#import "NSDictionary+CordovaPreferences.h"
#import "NSMutableArray+QueueAdditions.h"

FOUNDATION_EXPORT double CordovaVersionNumber;
FOUNDATION_EXPORT const unsigned char CordovaVersionString[];

