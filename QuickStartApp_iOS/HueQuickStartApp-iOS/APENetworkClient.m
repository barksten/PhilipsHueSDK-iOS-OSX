//
//  APENetworkClient.m
//  HueQuickStartApp-iOS
//
//  Created by Anders Östlin on 05/06/15.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import "APENetworkClient.h"

@implementation APENetworkClient

- (void)getMeetingsWithCompletionHandler:(void (^)(NSArray *meetings))completionHandler
{
    NSArray *meetings = @[@"test"];
    completionHandler(meetings);
}
                      
@end
