//
//  Server.m
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "Server.h"
#import "NewsModel.h"
#import "SocialModel.h"

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

+ (NSString *)getSocialNewsEndPoint:(NSString *)topicId
{
    return [NSString stringWithFormat:@"/topics/%@/social", topicId];
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

- (void)getSocialNews:(void (^)(NSArray *))success forTopicId:(NSString *)topicId failureHandler:(void (^)(NSError *))failure
{
    [self.manager GET:[Server getSocialNewsEndPoint:topicId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *result = [SocialModel arrayOfModelsFromDictionaries:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(result);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (NSString*)uploadForTopic:(NSString*)topicId
{
    return [NSString stringWithFormat:@"/topics/%@/upload",topicId];
}

- (void)uploadMovieForTopicWithID:(NSString*)topicID
                        movieData:(NSData*)movieData
                             name:(NSString*)name
                          success:(void(^)(void))success
                          failure:(void(^)(NSError*))failure
{
    [self.manager POST:[Server uploadForTopic:topicID] parameters:nil
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    [formData appendPartWithFileData:movieData name:@"video" fileName:@"jakichce" mimeType:@"video/mp4"];
    [formData appendPartWithFormData:[name dataUsingEncoding:NSUTF8StringEncoding]
                                name:@"name"];

} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    success();
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    failure(error);
}];
    
}

@end
