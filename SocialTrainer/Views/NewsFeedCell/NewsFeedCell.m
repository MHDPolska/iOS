//
//  NewsFeedCell.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "NewsFeedCell.h"
#import "SocialModel.h"
#import "SocialUserModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <XCDYouTubeVideoPlayerViewController.h>

@implementation NewsFeedCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
    return 215.f;
}


- (void)loadData:(SocialModel *)model
{
    self.text.text = model.content;
    [self.avatar setImageWithURL:[NSURL URLWithString:model.author.avatarUrl]
                         placeholderImage:[UIImage imageNamed:@"download.jpeg"]
                                  options:SDWebImageRefreshCached];
    self.avatar.layer.cornerRadius = 30.f;
    self.avatar.clipsToBounds = YES;
 
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:model.videoId];
    [videoPlayerViewController presentInView:self.ytView];
    [videoPlayerViewController.moviePlayer play];
}

@end
