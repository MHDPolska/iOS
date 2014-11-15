//
//  NewsHeaderCell.h
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHCell.h"

@interface NewsHeaderCell : MHCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *headerLabel;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImage;




@end
