//
//  MHCell.h
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHCellProtocol.h"

@interface MHCell : UITableViewCell
+ (NSString *)cellIdentifier;
- (void)loadData:(id)data;
+ (CGFloat)cellHeight;
@end
