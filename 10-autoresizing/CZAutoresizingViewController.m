//
//  CZAutoresizingViewController.m
//  10-autoresizing
//
//  Created by swan on 2024/9/5.
//

#import "CZAutoresizingViewController.h"

@interface CZAutoresizingViewController ()
@property (nonatomic, weak) UIView *blueView;

- (IBAction)btnClick:(UIButton *)sender;

@end

@implementation CZAutoresizingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建一个蓝色view
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = UIColor.blueColor;
    blueView.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:blueView];
    self.blueView = blueView;
    
    // 创建一个红色view
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = UIColor.redColor;
    [blueView addSubview:redView];
    
    CGFloat redW = blueView.frame.size.width;
    CGFloat redH = 50;
    CGFloat redX = 0;
    CGFloat redY = blueView.frame.size.height - redH;
    
    redView.frame = CGRectMake(redX, redY, redW, redH);
    
    // 设置autoresizing
    // 1. 设置红色view距离蓝色view的底部距离保持不变
    redView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    /*
     UIViewAutoresizingNone                   = 0,
     UIViewAutoresizingFlexibleLeftMargin     = 1 < 0, 距离父控件右边是固定的
     UIViewAutoresizingFlexibleWidth          = 1 < 1, 宽度随着父控件的变化而变化（表示勾选了里面的横线）
     UIViewAutoresizingFlexibleRightMargin    = 1 < 2, 距离左边是固定的
     UIViewAutoresizingFlexibleTopMargin      = 1 < 3, 距离下边是固定的
     UIViewAutoresizingFlexibleHeight         = 1 < 4, 高度随着父控件的变化而变化（表示勾选了里面的竖线）
     UIViewAutoresizingFlexibleBottomMargin   = 1 << 5 距离上边是固定的
     */
}


- (IBAction)btnClick:(UIButton *)sender {
    CGRect blueFrame = self.blueView.frame;
    blueFrame.size.height += 20;
    blueFrame.size.width += 20;
    self.blueView.frame = blueFrame;
}
@end
