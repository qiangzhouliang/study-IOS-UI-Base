//
//  CZAutolayoutViewController.m
//  10-autoresizing
//
//  Created by swan on 2024/9/5.
//

#import "CZAutolayoutViewController.h"

@interface CZAutolayoutViewController ()

@end

@implementation CZAutolayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建一个蓝色view
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = UIColor.blueColor;
//    blueView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:blueView];
    
    // 创建一个红色view
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
//    redView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:redView];
    
    // 禁用Autoresizing
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // 创建并添加约束
    // 1. 创建蓝色view和约束
    // 1.1 创建蓝色view高度的约束
    // A对象 的 某属性 等于 B对象 的 某属性 乘以 multiplier 加 constant
    // 参数1 的，参数2 参数3 参数4 的 参数5乘以 参数6 加 参数7
    NSLayoutConstraint *blueHC = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    // 把约束添加到控件上
    [blueView addConstraint:blueHC];
    // 1.2 距离左边30
    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    // 1.3 距离上边30 (self.view.safeAreaLayoutGuide 状态栏-安全距离)
    NSLayoutConstraint *blueTop = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:30];
    // 1.4 距离右边30
    NSLayoutConstraint *blueRight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    
    [blueView.superview addConstraints:@[blueLeft, blueTop, blueRight]];
    
    
    // 2.创建红色view的约束
    // 2.1 让红色view的height等于蓝色view的高度
    NSLayoutConstraint *redHC = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [redView.superview addConstraint:redHC];
    
    // 2. 让红色view的top距离蓝色view30
    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    [redView.superview addConstraint:redTop];
    
    // 2.3 红色view与蓝色view右对齐
    NSLayoutConstraint *redRight = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [redView.superview addConstraint:redRight];
    
    // 2.4 红色view的宽度等于蓝色view的宽度的0.5倍
    NSLayoutConstraint *redWidth = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    [redView.superview addConstraint:redWidth];
    
    
}

@end
