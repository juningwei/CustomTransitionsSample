//
//  SecondViewController.m
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/28.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic, strong)UIButton *dismissButton;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [img setImage:[UIImage imageNamed:@"iphoneImg"]];
    [self.view addSubview:img];
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dismissButton setFrame:CGRectMake(0, 0, 80, 30)];
    self.dismissButton.center = self.view.center;
    [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [self.dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissButton];
    
    self.dismissButton.alpha = self.dismiss ? 1 : 0;
    
}


- (void)back{
    self.dismiss ? [self dismissViewControllerAnimated:YES completion:^{
        self.dismiss = NO;
    }]: [self.navigationController popViewControllerAnimated:YES];
}



@end
