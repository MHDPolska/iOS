//
//  Server.m
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "Server.h"
#import "NewsModel.h"
@interface Server ()
@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) AFNetworkReachabilityManager* reachabilityManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation Server

+ (instancetype)sharedInstance
{
    static Server *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[Server alloc] init];
        _sharedInstance.baseURL = [NSURL URLWithString:@"http://socialreporter.herokuapp.com/"];
        _sharedInstance.manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://socialreporter.herokuapp.com/"]];
    });
    return _sharedInstance;
}

+ (NSString*)getTopicsEndPoint
{
    return @"/topics";
}


- (void)getTopics:(void(^)(NSArray*))succes failureHandler:(void(^)(NSError*))failure
{
    [self.manager GET:[Server getTopicsEndPoint] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSArray *result = [NewsModel arrayOfModelsFromDictionaries:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                succes(result);
            });
            
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
