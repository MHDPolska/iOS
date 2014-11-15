//
//  MHCell.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "MHCell.h"

@implementation MHCell
+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)loadData:(id)data
{
    
}

+ (CGFloat)cellHeight
{
    return 0.0f;
}


@end
