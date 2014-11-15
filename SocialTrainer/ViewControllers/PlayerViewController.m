//
//  PlayerViewController.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 16/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "PlayerViewController.h"
#import <XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.h>

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"bru0iNWJ13Q"];
    [videoPlayerViewController presentInView:self.view];
    [videoPlayerViewController.moviePlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
