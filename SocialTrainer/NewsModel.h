//
//  NewsModel.h
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "JSONModel.h"

@class ArticleModel;

@interface NewsModel : JSONModel

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) ArticleModel *article;

@end
