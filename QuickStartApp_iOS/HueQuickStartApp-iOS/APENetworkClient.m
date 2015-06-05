//
//  APENetworkClient.m
//  HueQuickStartApp-iOS
//
//  Created by Anders Östlin on 05/06/15.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import "APENetworkClient.h"

@implementation APENetworkClient

+ (NSArray *)parseMeetings:(NSData *)data
{
    NSError *mayBeError;
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &mayBeError];
    NSArray *meetings = object[@"meetings"];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithCapacity:meetings.count];
    for (NSDictionary *dict in meetings) {
        APEMeeting *meeting = [APEMeeting instanceFromJSON:dict];
        [temp addObject:meeting];
    }
    return temp.copy;

}

+ (void)getMeetingsWithCompletionHandler:(void (^)(NSArray *meetings))completionHandler
{
    BOOL useLocal = NO;
    if (useLocal) {
        NSURL *mockDataURL = [[NSBundle bundleForClass: self.class] URLForResource:@"meetings" withExtension:@"json"];
        NSData *data = [NSData dataWithContentsOfURL:mockDataURL];
        completionHandler([self parseMeetings:data]);
    }
    else {
        NSURLSession *session = NSURLSession.sharedSession;
        NSURLSessionDataTask *task = [session dataTaskWithHTTPGetRequest:[NSURL URLWithString:@"http://10.10.9.94/hack_june/api_meetings.php"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            completionHandler([self parseMeetings:data]);
        }];
        [task resume];
    }
}

@end
