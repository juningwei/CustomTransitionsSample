//
//  ViewController.m
//  CustomTransitionsSample
//
//  Created by 鞠凝玮 on 16/1/28.
//  Copyright © 2016年 hzdracom. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "SlowlyAnimation.h"
#import "SpringAnimation.h"
#import "FlipAnimation.h"
#import "SimplePresentAnimation.h"
#import "ShrinkDismissAnimation.h"
#import "BouncePresentAnimation.h"

typedef NS_ENUM(NSInteger, PushAnimationType){

    SlowlyPushAnimationType,
    SpringPushAnimationType,
    FlipPushAnimationType
};

typedef NS_ENUM(NSInteger, PresentAnimationType){
    BouncePresentAnimationType,
    ShrinkPresentAnimationType,
};

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, copy)NSArray *titleArray;

@property (nonatomic, assign)PushAnimationType pushType;
@property (nonatomic, assign)PresentAnimationType presentType;
@property (nonatomic, strong)SlowlyAnimation *slowlyAni;
@property (nonatomic, strong)SpringAnimation *springAni;
@property (nonatomic, strong)FlipAnimation *flipAni;
@property (nonatomic, strong)SimplePresentAnimation *simplePreAni;
@property (nonatomic, strong)ShrinkDismissAnimation *shrinkDisAni;
@property (nonatomic, strong)BouncePresentAnimation *bouncePreAni;
@end

@implementation ViewController

-(BouncePresentAnimation *)bouncePreAni{
    if (!_bouncePreAni){
        _bouncePreAni = [BouncePresentAnimation new];
    }
    return _bouncePreAni;
}

-(ShrinkDismissAnimation *)shrinkDisAni{
    if (!_shrinkDisAni){
        _shrinkDisAni = [ShrinkDismissAnimation new];
    }
    return _shrinkDisAni;
}

-(SimplePresentAnimation *)simplePreAni{
    if (!_simplePreAni){
        _simplePreAni = [SimplePresentAnimation new];
    }
    return _simplePreAni;
}

-(FlipAnimation *)flipAni{
    if (!_flipAni){
        _flipAni = [FlipAnimation new];
    }
    return _flipAni;
}

-(SpringAnimation *)springAni{
    if (!_springAni){
        _springAni = [SpringAnimation new];
    }
    return _springAni;
}

-(SlowlyAnimation *)slowlyAni{
    if (!_slowlyAni){
        _slowlyAni = [SlowlyAnimation new];
    }
    return _slowlyAni;
}

-(NSArray *)titleArray{
    if (!_titleArray){
        _titleArray = @[@[@"Slowly", @"Spring", @"Flip"],@[@"Slowly", @"Spring"]];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"CustomTransition";
    self.navigationController.delegate = self;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 44;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.titleArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    NSArray *arr = self.titleArray[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 0 ? @"Push" : @"Present";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    switch (indexPath.section) {
        case 0:
            self.pushType = indexPath.row;
            [self.navigationController pushViewController:secondVC animated:YES];

            break;
        case 1:
            self.presentType = indexPath.row;
            secondVC.transitioningDelegate = self;
            secondVC.dismiss = YES;
            [self.navigationController presentViewController:secondVC animated:YES completion:nil];
            break;

        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    if (operation == UINavigationControllerOperationPush){
        
        switch (self.pushType) {
            case SlowlyPushAnimationType:
                self.slowlyAni.reverse = NO;
                return self.slowlyAni;
                break;
            case SpringPushAnimationType:
                self.springAni.reverse = NO;
                return self.springAni;
                break;
            case FlipPushAnimationType:
                self.flipAni.reverse = NO;
                return self.flipAni;
                break;
        }

        return self.springAni;
    }
    
    if (operation == UINavigationControllerOperationPop){
        switch (self.pushType) {
            case SlowlyPushAnimationType:
                self.slowlyAni.reverse = YES;
                return self.slowlyAni;
                break;
            case SpringPushAnimationType:
                self.springAni.reverse = YES;
                return self.springAni;
                break;
            case FlipPushAnimationType:
                self.flipAni.reverse = YES;
                return self.flipAni;
                break;
        }

    }
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.navigationController.navigationBar.userInteractionEnabled = YES;

}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.simplePreAni.reverse = NO;
    switch (self.presentType) {
        case BouncePresentAnimationType:
            return self.simplePreAni;
            break;
        case ShrinkPresentAnimationType:
            return self.bouncePreAni;
            break;
     
    }
    return self.simplePreAni;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    switch (self.presentType) {
        case BouncePresentAnimationType:
            self.simplePreAni.reverse = YES;
            return self.simplePreAni;
            break;
        case ShrinkPresentAnimationType:
            return self.shrinkDisAni;
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
