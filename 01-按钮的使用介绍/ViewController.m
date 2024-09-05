//
//  ViewController.m
//  01-按钮的使用介绍
//
//  Created by swan on 2024/8/28.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *img;
- (IBAction)rotate:(UIButton *)sender;
- (IBAction)move:(UIButton *)sender;
- (IBAction)move:(UIButton *)sender;
- (IBAction)scale:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 通过更改Frame更改值
- (void)updateFrame:(UIButton *)sender {
    // 获取技钮的y坐标的值，让y的值递减，然后再把新的值赋值给按钮的y
    // 获取头像按钮的坐标
    // 获取按钮原始的frame值（这个frame中就包含了按钮的大小和坐标）
    CGRect orginFrame = self.img.frame;
    // 2 修改frame的值
    switch (sender.tag) {
        case 1:
            // 上
            // 设置y值-10
            orginFrame.origin.y -= 10;
            break;
        case 2:
            // 右
            // 设置x值+10
            orginFrame.origin.x += 10;
            break;
        case 3:
            // 下
            // 设置y值+10
            orginFrame.origin.y += 10;
            break;
        case 4:
            // 左
            // 设置x值-10
            orginFrame.origin.x -= 10;
            break;
    }
    // 把新的frame在赋值给按钮
    self.img.frame = orginFrame;
}

///通过更改center更改值
///通过中心点坐标来修改
- (void)updateCenter:(UIButton *)sender {
    CGPoint center = self.img.center;
    // 2 修改frame的值
    switch (sender.tag) {
        case 1:
            // 上
            // 设置y值-10
            center.y -= 10;
            break;
        case 2:
            // 右
            // 设置x值+10
            center.x += 10;
            break;
        case 3:
            // 下
            // 设置y值+10
            center.y += 10;
            break;
        case 4:
            // 左
            // 设置x值-10
            center.x -= 10;
            break;
    }
    // 把新的frame在赋值给按钮
    // 没有动画，直接执行
//    self.img.center = center;
    
    // 通过动画的方式来执行
    //1. 开启一个动画
    [UIView beginAnimations:nil context:nil];
    // 2. 设置动画执行时间
    [UIView setAnimationDuration:2];
    //================== 要执行的动画代码=========================
    self.img.center = center;
    //================== 要执行的动画代码=========================
    // 3. 提交动画
    [UIView commitAnimations];
}
/// 缩放
- (IBAction)scale:(UIButton *)sender {
    // 获取按钮原始的frame值（这个frame中就包含了按钮的大小和坐标）
    CGRect orginFrame = self.img.frame;
    // 2 修改frame的值
    switch (sender.tag) {
        case 1:
            // 放大
            orginFrame.size.width += 10;
            orginFrame.size.height += 10;
            break;
        case 2:
            // 缩写
            orginFrame.size.width -= 10;
            orginFrame.size.height -= 10;
            break;
    }
    // 把新的frame在赋值给按钮
//    self.img.frame = orginFrame;
    
    // block式开启动画
    [UIView animateWithDuration:2 animations:^{
        // 要执行的动画代码
        self.img.frame = orginFrame;
    }];
}
/// 移动
- (IBAction)move:(UIButton *)sender {
    
//    [self updateFrame:sender];
    [self updateCenter:sender];
}

- (IBAction)rotate:(UIButton *)sender {
}

- (IBAction)move:(UIButton *)sender {
}

@end
