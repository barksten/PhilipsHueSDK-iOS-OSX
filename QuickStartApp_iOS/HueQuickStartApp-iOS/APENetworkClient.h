//
//  APENetworkClient.h
//  HueQuickStartApp-iOS
//
//  Created by Anders Östlin on 05/06/15.
//  Copyright (c) 2015 Philips. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APENetworkClient : NSObject

- (void)getMeetingsWithCompletionHandler:(void (^)(NSArray *meetings))completionHandler;

@end
