//
//  CZAppView.m
//  03-应用管理
//
//  Created by swan on 2024/8/29.
//

#import "CZAppView.h"

@interface CZAppView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
- (IBAction)btnDownloadClick:(UIButton *)sender;

@end

@implementation CZAppView

- (void)setModel:(CZApp *)model{
    _model = model;
    
    // 解析模型数据，把模型数据赋值给UIView中的各个子控件
    self.imgViewIcon.image = [UIImage imageNamed:model.icon];
    self.lblName.text = model.name;
}

/// 为自定义View封装一个类方法
+ (instancetype)appView{
    // 1. 通过xib创建每个应用（UIView）
    // 通过动态加载xib文件创建里面的view
    // 1.1 找到应用根目录
    NSBundle *mainBundle = [NSBundle mainBundle]; // NSLog(@"%@", [mainBundle bundlePath]);
    // 1.2 在应用根目录下搜索对应的xib（nib）文件
    return [[mainBundle loadNibNamed:@"CZAppView" owner:nil options:nil] lastObject];
    
}

/// 下载按钮单击事件
- (IBAction)btnDownloadClick:(UIButton *)sender {
    NSLog(@"我被点击了");
    // 1. 禁用当前被点击的按钮
    sender.enabled = NO;
    
    // 2. 弹出一个消息提醒框（这个消息提醒框其实就是一个 UILabel）
    UILabel *lblMsg = [[UILabel alloc] init];
    // 2.1 设置 lblMsg 的显示文字
    lblMsg.text = @"正在下载...";
    lblMsg.textColor = UIColor.whiteColor;
    // 设置居中
    lblMsg.textAlignment = NSTextAlignmentCenter;
    // 设置字体大小
    lblMsg.font = [UIFont systemFontOfSize:12];
    // 设置透明度
    lblMsg.alpha = 0.0;  // 一开始把透明度设置为Q，然后通过动画的方式慢慢的改变透明度
    // 显示圆角
    lblMsg.layer.cornerRadius = 5;
    lblMsg.layer.masksToBounds = YES; // 把多余的部分裁剪掉
    // 2.2 设置背景颜色
    lblMsg.backgroundColor = UIColor.blackColor;
    // 2.3 设置lblMsg的frame
    CGFloat viewW = self.superview.frame.size.width;
    CGFloat viewH = self.superview.frame.size.height;
    CGFloat msgW = 200;
    CGFloat msgH = 30;
    CGFloat msgX = (viewW - msgW) * 0.5;
    CGFloat msgY = (viewH - msgH) * 0.5;
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
    
    // 通过动画的方式来显示 Label
    [UIView animateWithDuration:1.0 animations:^{
        lblMsg.alpha = 0.5;
    } completion:^(BOOL finished) {
        if (finished) {
            // 隔一段时间在启动另外一个动画
            [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationCurveLinear animations:^{
                // 这个代码的含义是，隔一段时间后再启动另外一个动画
                // 这个动画的执行时间是1.5秒钟，但是这个动画会在1.0秒之后再开始执行
                // UIViewAnimationOptionCurveLinear表示是匀速执行动画
                lblMsg.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    //当Label的透明度变成0以后，再把这个Label从view中移除
                    [lblMsg removeFromSuperview];
                }
            }];
        }
    }];
    
    // 3. 把 lblMsg 加到控制器所管理的那个view上
    [self.superview addSubview:lblMsg];
    
}


@end
