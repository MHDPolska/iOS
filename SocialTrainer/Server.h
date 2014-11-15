//
//  Server.h
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface Server : NSObject
+ (instancetype)sharedInstance;
- (void)getTopics:(void(^)(NSArray*))succes failureHandler:(void(^)(NSError*))failure;

@end
