//
//  NewsFeedCell.h
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHCell.h"


@interface NewsFeedCell : MHCell
@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *text;
@property (nonatomic, weak) IBOutlet UIView *ytView;

@end
