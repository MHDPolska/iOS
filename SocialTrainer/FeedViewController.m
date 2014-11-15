//
//  FeedViewController.m
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedCell.h"
#import "PCTransitionFromFirstToSecond.h"


@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSIndexPath *selectedCellIndexPath;

@end

@implementation FeedViewController

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
    
}

- (FeedCell*)getSelectedCell
{
    return (FeedCell*)[self.tableView cellForRowAtIndexPath:self.selectedCellIndexPath];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedCell *cell = (FeedCell*) [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    [cell loadData:nil];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCellIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UINavigationControllerDelegate


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {

    return [[PCTransitionFromFirstToSecond alloc]init];
}

@end

