//
//  SocialModel.h
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "JSONModel.h"
@class SocialUserModel;

@interface SocialModel : JSONModel
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) SocialUserModel *author;
@property (nonatomic, strong) NSString<Optional>* thumbnailURL;
@end
