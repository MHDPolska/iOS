//
//  FeedCell.h
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHCell.h"

@interface FeedCell : MHCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

- (UIView*)getVideoView;


@end

