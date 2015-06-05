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

- (PHLightState *)lightStateFromColor:(UIColor *)color andFlash:(BOOL)flash
{
    PHLightState *lightState = [[PHLightState alloc] init];
    if (flash) {
        [lightState setAlert:ALERT_LSELECT];
    }
    else {
        [lightState setAlert:ALERT_NONE];
    }
    
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
    [self updateLightsWithState:[self lightStateFromColor:[UIColor redColor] andFlash:YES]];
}

- (void)setHueWhite
{
    [self setHueColor:[UIColor whiteColor]];
}

- (void)setHueGreen
{
    [self setHueColor:[UIColor greenColor]];
}

- (void)setHueRed
{
    [self setHueColor:[UIColor redColor]];
}

- (void)setHueColor:(UIColor *)color
{
    [self updateLightsWithState:[self lightStateFromColor:color andFlash:NO]];
}

@end
