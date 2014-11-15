    //
//  FeedCell.m
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell


- (void)loadData:(id)data
{
    self.thumbnail.image = [UIImage imageNamed:@"download.jpeg"];
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
