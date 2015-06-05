//
//  APEMeeting.m
//  HueQuickStartApp-iOS
//
//  Created by Anders Östlin on 05/06/15.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import "APEMeeting.h"

@implementation APEMeeting

+ (APEMeeting *)instanceFromJSON:(NSDictionary *)JSON
{
    APEMeeting *meeting = APEMeeting.new;
    meeting.meetingID = JSON[@"id"];
    meeting.title = JSON[@"title"];
    meeting.agenda = JSON[@"agenda"];
    static NSDateFormatter *dateFormatter;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss'"];
    }
    
    meeting.start = [dateFormatter dateFromString:JSON[@"start_time"]];
    meeting.end = [dateFormatter dateFromString:JSON[@"end_time"]];
    
    NSMutableArray *topics = [[NSMutableArray alloc]init];
    for (NSDictionary *topicDict in JSON[@"topics"]) {
        [topics addObject:[APETopic instanceFromJSON:topicDict]];
    }
    meeting.topics = topics.copy;

    return meeting;
}

@end

@implementation APETopic

+ (APETopic *)instanceFromJSON:(NSDictionary *)JSON
{
    APETopic *newTopic = APETopic.new;
    newTopic.topicDescription = JSON[@"description"];
    newTopic.duration = JSON[@"time"];
    return newTopic;
}

@end
