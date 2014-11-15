//
//  RecordViewCell.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "RecordViewCell.h"

@implementation RecordViewCell

- (void)awakeFromNib {
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellIdentifier
{
    return @"RecordViewCell";
}

+ (CGFloat)cellHeight{
    return 54.f;
}

- (void)loadData:(id)data
{
    
}


@end
