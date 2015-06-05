//
//  APEMeeting.h
//  HueQuickStartApp-iOS
//
//  Created by Anders Östlin on 05/06/15.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APEMeeting : NSObject

@property (nonatomic, copy) NSString *meetingID;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *agenda;
@property (nonatomic, copy) NSDate *start;
@property (nonatomic, copy) NSDate *end;

@property (nonatomic, strong) NSArray *topics;

+ (APEMeeting *)instanceFromJSON:(NSDictionary *)JSON;

@end

@interface APETopic : NSObject

@property (nonatomic, copy) NSString *topicDescription;
@property (nonatomic, copy) NSNumber *duration;

+ (APETopic *)instanceFromJSON:(NSDictionary *)JSON;

@end
