//
//  APEHueHelper.m
//  HueQuickStartApp-iOS
//
//  Created by Anders Romin on 2015-06-05.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import "APEHueHelper.h"
#import <HueSDK_iOS/HueSDK.h>

@implementation APEHueHelper

- (void)setFlashing
{
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        
        [lightState setAlert:ALERT_LSELECT];
        
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
        }];
    }
}

- (void)setHueWhite
{
    [self setHueColor:[UIColor whiteColor]];
}

- (void)setHueRed
{
    [self setHueColor:[UIColor redColor]];
}

- (void)setHueColor:(UIColor *)color
{
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        
        CGFloat hue, sat, brig, alph;
        [color getHue:&hue saturation:&sat brightness:&brig alpha:&alph];
        
        [lightState setHue:[NSNumber numberWithDouble:(hue * 65535)]];
        [lightState setBrightness:[NSNumber numberWithDouble:(brig * 254)]];
        [lightState setSaturation:[NSNumber numberWithDouble:(sat * 254)]];
        
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
        }];
    }
}

@end
