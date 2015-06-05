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

#pragma mark - Helpers

- (void)updateLightsWithState:(PHLightState *)state
{
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:state completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
        }];
    }
}

- (PHLightState *)lightStateFromColor:(UIColor *)color
{
    PHLightState *lightState = [[PHLightState alloc] init];
    
    CGFloat hue, sat, brig, alph;
    [color getHue:&hue saturation:&sat brightness:&brig alpha:&alph];
    
    [lightState setHue:[NSNumber numberWithDouble:(hue * 65535)]];
    [lightState setBrightness:[NSNumber numberWithDouble:(brig * 254)]];
    [lightState setSaturation:[NSNumber numberWithDouble:(sat * 254)]];
    return lightState;
}

#pragma mark - Public Actions

- (void)setFlashing
{
    PHLightState *lightState = [[PHLightState alloc] init];
    [lightState setAlert:ALERT_LSELECT];
    [self updateLightsWithState:lightState];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setHueWhite];
    });
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
    [self updateLightsWithState:[self lightStateFromColor:color]];
}

@end
