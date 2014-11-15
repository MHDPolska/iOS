//
//  SocialUserModel.h
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "JSONModel.h"

@interface SocialUserModel : JSONModel
@property (nonatomic, strong) NSString *handle;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarUrl;

@end
