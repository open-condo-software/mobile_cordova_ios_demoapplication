/********* Condo.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#ifdef DOMA
#import "CordovaDemoApp-Swift.h"
#endif

@interface Condo: CDVPlugin 
{
  // Member variables go here.
}
- (void)requestAuthorization:(CDVInvokedUrlCommand *)command;
- (void)closeApplication:(CDVInvokedUrlCommand *)command;
- (void)getCurrentResident:(CDVInvokedUrlCommand *)command;
- (void)requestServerAuthorizationByUrl:(CDVInvokedUrlCommand *)command;
- (void)openURLWithFallback:(CDVInvokedUrlCommand *)command;
- (void)getLaunchContext:(CDVInvokedUrlCommand *)command;
- (void)setInputsEnabled:(CDVInvokedUrlCommand *)command;
- (void)historyBack:(CDVInvokedUrlCommand *)command;
- (void)historyPushState:(CDVInvokedUrlCommand *)command;
- (void)historyReplaceState:(CDVInvokedUrlCommand *)command;
- (void)historyGo:(CDVInvokedUrlCommand *)command;
#ifdef DOMA
@property (nonatomic, strong) DemoApplicationMainAppAPI *api;
#endif
@end

@implementation Condo

- (void)requestAuthorization:(CDVInvokedUrlCommand *)command
{
    NSString *clientId = [command.arguments objectAtIndex:0];
    NSString *clientSecret = [command.arguments objectAtIndex:1];
    
    if (clientId != nil && [clientId isKindOfClass:[NSString class]] && [clientId length] > 0) 
    {
#ifdef DOMA
        if (self.api == nil)
        {
            self.api = [[DemoApplicationMainAppAPI alloc] init];
        }
        [self.api getCodeWithClientID:clientId complition:^(NSString *code)
        {
            if (code != nil && [code isKindOfClass:[NSString class]] && [code length] > 0)
            {
                if (self.api == nil)
                {
                    self.api = [[DemoApplicationMainAppAPI alloc] init];
                }
                [self.api sendCodeToServerWithCode:code clientId:clientId clientSecret:clientSecret complition:^(NSString *authorization) {
                    if (authorization != nil && [authorization isKindOfClass:[NSString class]] && [authorization length] > 0)
                    {
                        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:authorization] callbackId:command.callbackId];
                    }
                    else
                    {
                        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
                    }
                }];
            }
            else
            {
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
            }
        }];
#else
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"test_code_for_auth"] callbackId:command.callbackId];
#endif
    } 
    else 
    {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
    }
}

- (BOOL)nonEmptyString:(NSString *)string
{
    return (string != nil && [string isKindOfClass:[NSString class]] && [string length] > 0);
}

- (void)requestServerAuthorizationByUrl:(CDVInvokedUrlCommand *)command
{
    NSString *url = [command.arguments objectAtIndex:0];
//    reserved for future use
//    NSString *custom_params = [command.arguments objectAtIndex:1];
    
    if ([self nonEmptyString:url])
    {
#ifdef DOMA
        if (self.api == nil)
        {
            self.api = [[DemoApplicationMainAppAPI alloc] init];
        }
        [self.api getFullAuthByUrlWithUrl:url complition:^(NSDictionary *result) {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result] callbackId:command.callbackId];
        }];
#else
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"test_code_for_auth"] callbackId:command.callbackId];
#endif
    }
    else
    {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
    }
}

- (void)openURLWithFallback:(CDVInvokedUrlCommand *)command
{
    NSString *url = [command.arguments objectAtIndex:0];
    NSString *fallback_url = [command.arguments objectAtIndex:1];
    if ([self nonEmptyString:url])
    {
        NSURL *firstURL = [NSURL URLWithString:url];
        [[UIApplication sharedApplication] openURL:firstURL options:@{} completionHandler:^(BOOL success) {
            if (!success)
            {
                NSURL *fallbackURL = [NSURL URLWithString:fallback_url];
                [[UIApplication sharedApplication] openURL:fallbackURL options:@{} completionHandler:^(BOOL success) {}];
            }
        }];
    }
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)closeApplication:(CDVInvokedUrlCommand *)command
{
#ifdef DOMA
    [[CondoSupport getInstance] closeApp];
#endif
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)getCurrentResident:(CDVInvokedUrlCommand *)command
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[@"{\"unitName\":\"88\",\"dv\":1,\"property\":{\"id\":\"f983420a-250b-4dfd-bcb4-68086fa5e8bb\",\"name\":\"3\"},\"organizationName\":\"Пропуск дай\",\"organizationFeatures\":{\"hasBillingData\":false,\"hasMeters\":false},\"createdAt\":\"2023-08-21T13:21:46.054+0500\",\"_label_\":\"b3088f60-8fe2-4046-8188-d0c4791ca3fb\",\"organization\":{\"id\":\"dc1716f6-d8a8-49ca-b935-d0a0d022d330\",\"v\":1,\"updatedAt\":\"2023-08-17T14:13:46.956+0500\",\"_label_\":\"Пропуск дай -- <dc1716f6-d8a8-49ca-b935-d0a0d022d330>\",\"onlyGreaterThanPreviousMeterReadingIsEnabled\":false,\"dv\":1,\"ticketSubmittingIsDisabled\":false,\"tin\":\"000000000000\",\"__typename\":\"Organization\",\"sender\":{\"dv\":1},\"country\":\"ru\",\"name\":\"Пропуск дай\"},\"v\":1,\"paymentCategories\":[{\"id\":\"1\",\"acquiringName\":\"default\",\"billingName\":\"default\",\"categoryName\":\"Квартплата\"},{\"id\":\"3\",\"acquiringName\":\"default\",\"billingName\":\"default\",\"categoryName\":\"Электричество\"},{\"id\":\"5\",\"acquiringName\":\"default\",\"billingName\":\"default\",\"categoryName\":\"ХВС\"},{\"id\":\"6\",\"acquiringName\":\"default\",\"billingName\":\"default\",\"categoryName\":\"Отопление и ГВС\"},{\"id\":\"7\",\"acquiringName\":\"default\",\"billingName\":\"default\",\"categoryName\":\"ТКО\"},{\"id\":\"9\",\"acquiringName\":\"default\",\"billingName\":\"default\",\"categoryName\":\"Капремонт\"}],\"updatedAt\":\"2023-08-21T13:21:46.054+0500\",\"id\":\"b3088f60-8fe2-4046-8188-d0c4791ca3fb\",\"createdBy\":{\"sender\":{\"dv\":1},\"id\":\"8e0f7830-4c75-4e5a-9115-ebefa1ebaf3d\",\"v\":2,\"updatedAt\":\"2023-05-22T16:01:05.655+0500\",\"createdAt\":\"2023-05-22T16:00:55.595+0500\",\"type\":\"resident\",\"name\":\"Фыфв\",\"dv\":1},\"unitType\":\"flat\",\"propertyId\":\"f983420a-250b-4dfd-bcb4-68086fa5e8bb\",\"sender\":{\"dv\":1},\"user\":{\"sender\":{\"dv\":1},\"id\":\"8e0f7830-4c75-4e5a-9115-ebefa1ebaf3d\",\"v\":2,\"updatedAt\":\"2023-05-22T16:01:05.655+0500\",\"createdAt\":\"2023-05-22T16:00:55.595+0500\",\"type\":\"resident\",\"name\":\"Фыфв\",\"dv\":1},\"updatedBy\":{\"sender\":{\"dv\":1},\"id\":\"8e0f7830-4c75-4e5a-9115-ebefa1ebaf3d\",\"v\":2,\"updatedAt\":\"2023-05-22T16:01:05.655+0500\",\"createdAt\":\"2023-05-22T16:00:55.595+0500\",\"type\":\"resident\",\"name\":\"Фыфв\",\"dv\":1},\"organizationId\":\"dc1716f6-d8a8-49ca-b935-d0a0d022d330\",\"propertyName\":\"3\",\"addressMeta\":{\"value\":\"г Ростов-на-Дону, ул Кудрявая, д 6\",\"data\":{\"cityTypeFull\":\"город\",\"region\":\"Ростовская\",\"taxOfficeLegal\":\"6193\",\"regionIsoCode\":\"RU-ROS\",\"street\":\"Кудрявая\",\"country\":\"Россия\",\"taxOffice\":\"6193\",\"cityWithType\":\"г Ростов-на-Дону\",\"regionWithType\":\"Ростовская обл\",\"oktmo\":\"60701000001\",\"capitalMarker\":\"2\",\"streetFiasId\":\"82c32cdd-3d0a-441e-98e6-e39d8f273f37\",\"qcGeo\":\"2\",\"regionTypeFull\":\"область\",\"geoLat\":\"47.289813\",\"countryIsoCode\":\"RU\",\"streetType\":\"ул\",\"postalCode\":\"344093\",\"cityFiasId\":\"c1cfe4b9-f7c2-423c-abfa-6ed1c05a15c5\",\"cityKladrId\":\"6100000100000\",\"geonameId\":\"501175\",\"streetWithType\":\"ул Кудрявая\",\"cityType\":\"г\",\"okato\":\"60401000000\",\"federalDistrict\":\"Южный\",\"city\":\"Ростов-на-Дону\",\"houseType\":\"д\",\"streetTypeFull\":\"улица\",\"houseTypeFull\":\"дом\",\"fiasId\":\"f2a0188c-37c4-4e0c-afc8-85ff552b8429\",\"regionFiasId\":\"f10763dc-63e3-48db-83e1-9c566fe3092b\",\"fiasLevel\":\"8\",\"regionKladrId\":\"6100000000000\",\"house\":\"6\",\"regionType\":\"обл\",\"fiasActualityState\":\"0\",\"geoLon\":\"39.793822\",\"kladrId\":\"6100000100024670013\",\"houseFiasId\":\"f2a0188c-37c4-4e0c-afc8-85ff552b8429\",\"streetKladrId\":\"61000001000246700\",\"houseKladrId\":\"6100000100024670013\"},\"unrestrictedValue\":\"344093, Ростовская обл, г Ростов-на-Дону, ул Кудрявая, д 6\"},\"address\":\"г Ростов-на-Дону, ул Кудрявая, д 6\"}" dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic] callbackId:command.callbackId];
}

- (void)getLaunchContext:(CDVInvokedUrlCommand *)command
{
    NSString *context = @"{\"test\": 1}";
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:context] callbackId:command.callbackId];
}

- (void)setInputsEnabled:(CDVInvokedUrlCommand *)command
{
    NSNumber *interactionEnabled = [command.arguments objectAtIndex:0];
    if ([self.viewController isKindOfClass:[CDVViewController class]]) {
        if (@available(iOS 14.5, *)) {
            [((WKWebView *)((CDVViewController *)self.viewController).webView).configuration.preferences setTextInteractionEnabled:[interactionEnabled boolValue]];
        }
    }
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)historyBack:(CDVInvokedUrlCommand *)command
{
    #ifdef DOMA
    if ([self.viewController isKindOfClass:[MiniappCordovaViewController class]]) {
        NSString *error = [((MiniappCordovaViewController *)self.viewController) back];
        if (error)
        {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error] callbackId:command.callbackId];
            return;
        }
    }
    #endif
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)historyPushState:(CDVInvokedUrlCommand *)command
{
    #ifdef DOMA
    NSObject *state = [command.arguments objectAtIndex:0];
    NSString *title = [command.arguments objectAtIndex:1];
    if ([title isEqual:[NSNull null]] || title == nil)
    {
        title = @"";
    }
    if ([self.viewController isKindOfClass:[MiniappCordovaViewController class]]) {
        NSString *error = [((MiniappCordovaViewController *)self.viewController) pushStateWithState:state title:title];
        if (error)
        {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error] callbackId:command.callbackId];
            return;
        }
    }
    #endif
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)historyReplaceState:(CDVInvokedUrlCommand *)command
{
    #ifdef DOMA
    NSObject *state = [command.arguments objectAtIndex:0];
    NSString *title = [command.arguments objectAtIndex:1];
    if ([title isEqual:[NSNull null]] || title == nil)
    {
        title = @"";
    }
    if ([self.viewController isKindOfClass:[MiniappCordovaViewController class]]) {
        NSString *error = [((MiniappCordovaViewController *)self.viewController) replaceStateWithState:state title:title];
        if (error)
        {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error] callbackId:command.callbackId];
            return;
        }
    }
    #endif
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void)historyGo:(CDVInvokedUrlCommand *)command
{
    #ifdef DOMA
    NSNumber *amount = [command.arguments objectAtIndex:0];
    if ([amount isEqual:[NSNull null]] || amount == nil)
    {
        amount = [NSNumber numberWithInt:1];
    }
    if ([self.viewController isKindOfClass:[MiniappCordovaViewController class]]) {
        NSString *error = [((MiniappCordovaViewController *)self.viewController) goTo:amount.integerValue];
        if (error)
        {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error] callbackId:command.callbackId];
            return;
        }
    }
    #endif
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

@end
