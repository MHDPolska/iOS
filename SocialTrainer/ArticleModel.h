//
//  ArticleModel.h
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "JSONModel.h"

@interface ArticleModel : JSONModel

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSArray *pictureUrls;

@end
