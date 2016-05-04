//
//  FlipAnimation.h
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/29.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FlipAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign)BOOL reverse;
@end
