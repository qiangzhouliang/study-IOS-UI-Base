//
//  ViewController.m
//  02-Transform属性介绍
//
//  Created by swan on 2024/8/28.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
- (IBAction)scale:(UIButton *)sender;
- (IBAction)move:(UIButton *)sender;
- (IBAction)rotate:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)scale:(UIButton *)sender {
    NSLog(@"缩放");
    // x 和 y 同时缩放 1.5倍
//    self.btnIcon.transform = CGAffineTransformMakeScale(1.5, 1.5);
    
    self.btnIcon.transform = CGAffineTransformScale(self.btnIcon.transform, 1.5, 1.5);
    
}
- (IBAction)move:(UIButton *)sender{
    NSLog(@"平移");
    // 1. 获取原始的结构体值（获取原来的结构体的值，是为了基于原来的值进行修改。）
//    CGAffineTransform transform = self.btnIcon.transform;
    
    // 2. 修改结构体值
    //下面这句话的意思是：告诉控件，平移到距离原始位置-50的位置
//    self.btnIcon.transform = CGAffineTransformMakeTranslation(0, -50);
    
    // 基于一个旧的值，在进行平移
    self.btnIcon.transform = CGAffineTransformTranslate(self.btnIcon.transform, 0, 50);
    
    // 3. 重新赋值
    
}
- (IBAction)rotate:(UIButton *)sender{
    NSLog(@"旋转");
    // 45度
//    self.btnIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [UIView animateWithDuration:2 animations:^{
        self.btnIcon.transform = CGAffineTransformRotate(self.btnIcon.transform, M_PI_4);
    }];
}
@end


