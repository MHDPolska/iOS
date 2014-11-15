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
#import "Server.h"
#import "NewsDetailsViewController.h"


@interface FeedViewController () <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSIndexPath *selectedCellIndexPath;

@property (nonatomic,strong) NSArray *newsFeed;

@end

@implementation FeedViewController

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    [[Server sharedInstance]getTopics:^(NSArray *news) {
        self.newsFeed = news;
        [self.tableView reloadData];
    } failureHandler:^(NSError *e) {
        NSLog(@"%@",e);
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
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
    [cell loadData:self.newsFeed[indexPath.row]];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsFeed.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCellIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"showDetails" sender:self.newsFeed[indexPath.row]];
}


#pragma mark - UINavigationControllerDelegate


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {

    return [[PCTransitionFromFirstToSecond alloc]init];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NewsDetailsViewController *destiantion = (NewsDetailsViewController *)segue.destinationViewController;
    destiantion.news = (NewsModel*)sender;
}

@end

