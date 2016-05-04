//
//  SpringAnimation.m
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/28.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "SpringAnimation.h"

@implementation SpringAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return self.reverse ? 0.2 : 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (!self.reverse){
        CGRect finalFrame = toVC.view.frame;
        toVC.view.frame = CGRectOffset(finalFrame, -bounds.size.width, bounds.size.height);
        [containerView addSubview:toVC.view];
        
        //    fromVC.view.alpha = 0.5;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            toVC.view.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            //        fromVC.view.alpha = 1;
        }];

    }else{
        CGRect finalFrame = CGRectOffset(fromVC.view.frame, -bounds.size.width, bounds.size.height);
        [containerView addSubview:toVC.view];
        [containerView sendSubviewToBack:toVC.view];
        //    fromVC.view.alpha = 0.5;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.frame = finalFrame;

        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];

        }];
        

    }

}
@end
