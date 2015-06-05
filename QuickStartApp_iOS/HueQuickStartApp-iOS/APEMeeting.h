//
//  APEMeeting.h
//  HueQuickStartApp-iOS
//
//  Created by Anders Östlin on 05/06/15.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APEMeeting : NSObject

@property (nonatomic, strong) NSString *meetingID;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *agenda;
@property (nonatomic, strong) NSDate *start;
@property (nonatomic, strong) NSDate *end;

+ (APEMeeting *)instanceFromJSON:(NSDictionary *)JSON;

@end
