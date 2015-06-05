//
//  APENetworkClient.m
//  HueQuickStartApp-iOS
//
//  Created by Anders Östlin on 05/06/15.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import "APENetworkClient.h"
#import "APEMeeting.h"

@implementation APENetworkClient

+ (void)getMeetingsWithCompletionHandler:(void (^)(NSArray *meetings))completionHandler
{
    NSURL *mockDataURL = [[NSBundle bundleForClass: self.class] URLForResource:@"meetings" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:mockDataURL];
    NSError *mayBeError;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &mayBeError];
    NSArray *meetings = object[@"meetings"];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithCapacity:meetings.count];
    for (NSDictionary *dict in meetings) {
        APEMeeting *meeting = [APEMeeting instanceFromJSON:dict];
        [temp addObject:meeting];
    }
    completionHandler(temp.copy);
}

@end
