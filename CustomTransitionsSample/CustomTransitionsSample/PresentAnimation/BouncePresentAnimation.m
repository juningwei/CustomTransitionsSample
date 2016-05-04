//
//  BouncePresentAnimation.m
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/29.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "BouncePresentAnimation.h"

@implementation BouncePresentAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.9;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    UIView *containerView = [transitionContext containerView];
    CGRect screenBounds = [[UIScreen mainScreen]bounds];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    [containerView addSubview:toVC.view];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.alpha = 0.5;
        toVC.view.frame = finalFrame;
        
    } completion:^(BOOL finished) {
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:YES];
        
    }];
}

@end
