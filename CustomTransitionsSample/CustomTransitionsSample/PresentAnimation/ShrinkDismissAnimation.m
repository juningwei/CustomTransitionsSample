//
//  ShrinkDismissAnimation.m
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/29.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "ShrinkDismissAnimation.h"

#define IOS7UIViewSnapshots

@implementation ShrinkDismissAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.8;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    
    CGRect bounds = [[UIScreen mainScreen]bounds];
    CGRect midFrame = CGRectInset(fromVC.view.frame, bounds.size.width/4.0, bounds.size.height/4.0);
    CGRect finalFrame = CGRectOffset(midFrame, 0, bounds.size.height);
    
    toVC.view.alpha = 0.5;
    
#ifdef IOS7UIViewSnapshots
    
    UIView *intermediaView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    intermediaView.frame = fromVC.view.frame;
    [containerView addSubview:intermediaView];
    [fromVC.view removeFromSuperview];
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            intermediaView.frame = midFrame;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            intermediaView.frame = finalFrame;
        }];
    } completion:^(BOOL finished) {
        toVC.view.alpha = 1;
        [transitionContext completeTransition:YES];
    }];
    
    
#else
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            fromVC.view.layer.affineTransform = CGAffineTransformMakeScale(0.5, 0.5);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            fromVC.view.frame = finalFrame;
        }];
    } completion:^(BOOL finished) {
        toVC.view.alpha = 1;
        [transitionContext completeTransition:YES];
    }];

#endif
}

@end
