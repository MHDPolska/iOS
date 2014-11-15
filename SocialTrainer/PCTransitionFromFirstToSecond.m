//
//  PCTransitionFromFirstToSecond.m
//  SocialTrainer
//
//  Created by Adam Szeptycki on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "PCTransitionFromFirstToSecond.h"
#import "FeedViewController.h"
#import "FeedCell.h"

@implementation PCTransitionFromFirstToSecond

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    FeedViewController *feedViewController = (FeedViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *cellVideoView = [[feedViewController getSelectedCell] getVideoView];
    
    
    destinationViewController.view.frame = [transitionContext finalFrameForViewController:destinationViewController];
    destinationViewController.view.alpha = 0;
//todo mark video view as invisible
    
    
    [containerView addSubview:destinationViewController.view];
    [containerView addSubview:cellVideoView];

    
    
    [UIView animateWithDuration:0.3 animations:^{
        destinationViewController.view.alpha = 1.0;
        CGRect frame = CGRectMake(0, 0, 320, 400);
        cellVideoView.frame = frame;
    }completion:^(BOOL finished) {
//todo mark video view as invisible
        [cellVideoView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}


@end
