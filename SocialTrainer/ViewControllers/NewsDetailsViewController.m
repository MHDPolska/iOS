//
//  NewsDetailsViewController.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "NewsDetailsViewController.h"

@interface NewsDetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation NewsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}


@end
