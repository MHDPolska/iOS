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
    return 0.6;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    FeedViewController *feedViewController = (FeedViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *cellVideoView = [[feedViewController getSelectedCell] getVideoView];
    
    UIView *cellImageSnapshot = [cellVideoView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:cellVideoView.frame fromView:cellVideoView.superview];
    destinationViewController.view.alpha = 0;

    [containerView addSubview:destinationViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:0.6
                     animations:^{
        destinationViewController.view.alpha = 1.0;
        CGRect frame = CGRectMake(0, 64, 375, 200);
        cellImageSnapshot.frame = frame;
    }completion:^(BOOL finished) {
        [cellImageSnapshot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}


@end
