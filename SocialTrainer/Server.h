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
- (void)getSocialNews:(void (^)(NSArray *))success forTopicId:(NSString *)topicId failureHandler:(void (^)(NSError *))failure;
- (void)uploadMovieForTopicWithID:(NSString*)topicID
                        movieData:(NSData*)movieData
                             name:(NSString*)name
                          success:(void(^)(void))success
                          failure:(void(^)(NSError*))failure;

@end
