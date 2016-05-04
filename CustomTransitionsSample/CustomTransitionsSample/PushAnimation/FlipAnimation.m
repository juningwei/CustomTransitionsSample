//
//  FlipAnimation.m
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/29.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "FlipAnimation.h"

@implementation FlipAnimation
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    CATransform3D transfrom = CATransform3DIdentity;
    transfrom.m34 = -1.0/500;
    containerView.layer.sublayerTransform = transfrom;
    [containerView addSubview:toVC.view];
    
    float factor = self.reverse ? -1 : 1;
    toVC.view.layer.transform = CATransform3DMakeRotation(factor*M_PI_2, 0, 1, 0);
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            fromVC.view.layer.transform = CATransform3DMakeRotation(-factor*M_PI_2, 0, 1, 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            toVC.view.layer.transform = CATransform3DMakeRotation(0, 0, 1, 0);
        }];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
