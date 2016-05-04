//
//  SimplePresentAnimation.m
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/29.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "SimplePresentAnimation.h"

@implementation SimplePresentAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    CGRect bounds = [[UIScreen mainScreen]bounds];
    if (!self.reverse){
        CGRect finalFrame = toVC.view.frame;
        toVC.view.frame = CGRectOffset(toVC.view.frame, 0, bounds.size.height);
        [containerView addSubview:toVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];

    }else{
        CGRect finalFrame = CGRectOffset(fromVC.view.frame, 0, bounds.size.height);
        [containerView addSubview:toVC.view];
        [containerView sendSubviewToBack:toVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];

    }
}
@end
