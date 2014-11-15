//
//  NewsDetailsViewController.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "NewsFeedCell.h"
#import "NewsHeaderCell.h"
#import "NewsTitleCell.h"
#import "NewsVideoCell.h"


@interface NewsDetailsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *cellsData;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end

@implementation NewsDetailsViewController
@synthesize cellsData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    cellsData = @[@{@"cellIdentifier":[NewsTitleCell cellIdentifier], @"height": @([NewsTitleCell cellHeight])},
                 @{@"cellIdentifier":[NewsHeaderCell cellIdentifier], @"height": @([NewsHeaderCell cellHeight])},
                 @{@"cellIdentifier":[NewsFeedCell cellIdentifier], @"height": @([NewsFeedCell cellHeight])},
                 @{@"cellIdentifier":[NewsVideoCell cellIdentifier], @"height": @([NewsVideoCell cellHeight])}
                 ];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = self.cellsData[indexPath.row];
    
    MHCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData[@"cellIdentifier"]
                                           forIndexPath:indexPath];
    [cell loadData:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = self.cellsData[indexPath.row];
    return [cellData[@"height"] floatValue];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellsData.count;
}

@end
