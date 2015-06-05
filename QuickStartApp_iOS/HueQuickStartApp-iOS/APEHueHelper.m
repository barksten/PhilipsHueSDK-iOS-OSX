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
- (void) setHueRed {
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        
        [lightState setHue:@0];
        [lightState setBrightness:@254];
        [lightState setSaturation:@254];
        
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
