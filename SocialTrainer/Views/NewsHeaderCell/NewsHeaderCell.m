//
//  NewsHeaderCell.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "NewsHeaderCell.h"
#import "NewsModel.h"
#import "ArticleModel.h"
#import <SDWebImage/UIImageView+WebCache.h>



@implementation NewsHeaderCell

- (void)awakeFromNib {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(id)data
{
    NewsModel *newsModel = (NewsModel *)data;
    self.titleLabel.text = newsModel.article.title;
    self.headerLabel.text = newsModel.article.summary;
    
    [self.backgroundImage setImageWithURL:[NSURL URLWithString:newsModel.article.pictureUrls.firstObject]
                   placeholderImage:[UIImage imageNamed:@"download.jpeg"]
                            options:SDWebImageRefreshCached];
    
}

+ (CGFloat)cellHeight
{
    return 215.f;
}

@end
