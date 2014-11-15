    //
//  FeedCell.m
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "FeedCell.h"
#import "NewsModel.h"
#import "ArticleModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface FeedCell ()


@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UILabel *title;



@end



@implementation FeedCell

- (void)loadData:(NewsModel*)newsModel
{
    self.title.text = newsModel.article.title;
    self.info.text = newsModel.article.summary;
    [self.thumbnail setImageWithURL:[NSURL URLWithString:newsModel.article.pictureUrls.firstObject]
                   placeholderImage:[UIImage imageNamed:@"placeholder"]
                            options:SDWebImageRefreshCached];
}

- (UIView*)getVideoView
{
    return self.thumbnail;
}

+ (CGFloat)cellHeight
{
    return 200;
}

@end
