//
//  ViewController.m
//  04-超级猜图
//
//  Created by swan on 2024/8/30.
//

#import "ViewController.h"
#import "CZQuestion.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
- (IBAction)scroll:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnScore;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;

// 用来引用那个“阴影“按钮的属性
@property (weak, nonatomic) UIButton *cover;
-(IBAction)btnNextClicked;
-(IBAction)bigImageClicked;
-(IBAction)btnIconClicked;
-(IBAction)btnTipClicked;

// 所以问题的数据都在这个数组当中
@property(nonatomic, strong)NSArray *questions;

// 控制题目索引
@property(nonatomic, assign)int index;

// 记录头像按钮原始的frame
@property(nonatomic, assign)CGRect iconFrame;

@end

@implementation ViewController

// 懒加载数据
- (NSArray *)questions{
    if (_questions == nil) {
        // 加载数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            CZQuestion *model = [CZQuestion questionWithDict:dict];
            [arrayModel addObject:model];
        }
        _questions = arrayModel;
    }
    return _questions;
}

// 改变状态栏文字颜色为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = -1;
    // 初始化显示第一题
    [self nextQuestion];
}

// 点击下一题
-(IBAction)btnNextClicked{
    [self nextQuestion];
}
// 点击提示按钮
-(IBAction)btnTipClicked{
    // 1. 减 1000 分
    int currentScore = [self addScore:-1000];
    if (currentScore < 0) {
        
        return;
    }
    // 2. 把所有的答案按钮"清空”（其实这里的"清空”最好是调用每个答案按钮的单击事件）
    for (UIButton *btnAnswer in self.answerView.subviews) {
        // 让每个答案按钮点击一下
        [self btnAnswerClick:btnAnswer];
    }
    
    // 3.根据当前的索引，从数据数组中（self.questions）中找到对应的数据模型
    // 从数据模型中获取正确答案的第一个字符，把待选按钮中和这个字符相等的那个按钮点击一下
    CZQuestion *model = self.questions[self.index];
    NSString *firstChar = [model.answer substringToIndex:1];
    // 根据firstChar在option按钮中找到对应的option 按钮，让这个按钮点击一下
    for (UIButton *btnOption in self.optionsView.subviews) {
        if ([btnOption.currentTitle isEqualToString:firstChar]) {
            [self optionButtonClick:btnOption];
            break;
        }
    }
    
}

/// 加载数据，把模型数据设置到界面的控件上
- (void)settingData:(CZQuestion *)model {
    self.lblIndex.text = [NSString stringWithFormat:@"%d / %d",(self.index + 1), self.questions.count];
    self.lblTitle.text = model.title;
    [self.btnIcon setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    
    // 4. 设置到达最后一题以后，禁用下一题按钮
    self.btnNext.enabled = (self.index != self.questions.count - 1);
}

/// 创建答案按钮
- (void)makeAnswerButtons:(CZQuestion *)model {
    // 5. 动态创建答案按钮
    // 清楚所有的答案按钮
    // 方法1
//    while (self.answerView.subviews.firstObject) {
//        [self.answerView.subviews.firstObject removeFromSuperview];
//    }
    // 方法2
    //这句话的意思：让subviews这个数组中的每个对象，分别调用一次removeFromSuperview方法，内部执行了循环，无需我们自己来些循环
    [self.answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 5.1 获取当前答案的文字
    NSUInteger len = model.answer.length;
    // 5.2 循环创建答案按钮，有几个文字就创建几个按钮
    // 设置按钮frame
    CGFloat margin = 10; // 假设每个按钮之间的间距都是10
    CGFloat answerW = 35;
    CGFloat answerH = 35;
    CGFloat answerY = 0;
    CGFloat marginLeft = (self.view.frame.size.width - (len * answerW) - (len - 1) * margin)/2;
    
    for (int i = 0; i < len; i++) {
        UIButton *btnAnswer = [[UIButton alloc] init];
        // 设置按钮背景
        [btnAnswer setBackgroundColor:UIColor.whiteColor];
        [btnAnswer setTitleColor:UIColor.blackColor forState:UIControlStateNormal ];
        // 设置按钮frame
        CGFloat answerX = marginLeft + i * (answerW + margin);
        btnAnswer.frame = CGRectMake(answerX, answerY, answerW, answerH);
        
        // 把按钮加到answerView中
        [self.answerView addSubview:btnAnswer];
        
        // 为答案按钮注册点击事件
        [btnAnswer addTarget:self action:@selector(btnAnswerClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

/// 为答案按钮 点击事件
/// 参数sender，就表示当前点击的答案按钮
-(void)btnAnswerClick:(UIButton *)sender{
    // 0. 启用option view与用户的交互
    self.optionsView.userInteractionEnabled = YES;
    // 设置答案按钮字体颜色为黑色
    [self setAnswerButtonsTitleColot:UIColor.blackColor];
    
    // 2. 在“待选按钮”中找到与当前被点击的答案按钮文字相同待选按钮，设置该按钮显示出来。
    for (UIButton *optBtn in self.optionsView.subviews) {
        // 比较判断待选按钮的文字是否与当前被点击的答案按钮的文字一致
        if (optBtn.tag == sender.tag) {
            optBtn.hidden = NO;
            break;
        }
    }
    
    // 1． 清空当前被点击的答案按钮的文字
    [sender setTitle:nil forState:UIControlStateNormal];
}

/// 下一题
-(void)nextQuestion{
    // 1. 让索引++
    self.index ++;
    // 判断当前索引是否越界，如果越界，则提示用户
    if(self.index == self.questions.count){
        NSLog(@"答题结束");
        // 弹出一个对话框
        UIAlertController *toast = [UIAlertController alertControllerWithTitle:@"操作提示" message:@"恭喜通关" preferredStyle:UIAlertControllerStyleAlert];
        // 创建UIAlertAction，用于处理按钮点击事件
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 隐藏弹出框
            [toast dismissViewControllerAnimated:true completion:nil];
            // 让程序在回到第0个问题
            self.index = -1;
            [self nextQuestion];
        }];
        // 将UIAlertAction添加到UIAlertController
        [toast addAction:alertAction];
        // 获取当前视图控制器显示弹框
        [self presentViewController:toast animated:true completion:nil];
        
        return;
    }
    
    // 2. 根据索引获取当前的模型数据
    CZQuestion *model = self.questions[self.index];
    
    // 3. 把模型数据设置到界面对应的控件上
    [self settingData:model];
    
    // 4. 创建答案按钮
    [self makeAnswerButtons:model];
    
    // 5. 创建待选项按钮
    [self makeOptionsButtons:model];
    
}

// 创建待选项按钮
- (void)makeOptionsButtons:(CZQuestion *)model {
    // 0 设置 Options View 可以与用户交互
    self.optionsView.userInteractionEnabled = YES;
    
    // 5. 创建待选项按钮
    // 1. 清楚所有的待选项按钮
    // 方法2
    //这句话的意思：让subviews这个数组中的每个对象，分别调用一次removeFromSuperview方法，内部执行了循环，无需我们自己来些循环
    [self.optionsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 2 获取当前题目的待选文字的数组
    NSArray *words = model.options;
    
    // 3 根据待选文字循环来创建按钮
    
    // 5.1 一行显示几个
    NSUInteger rowCount = 7;
    // 5.2 循环创建答案按钮，有几个文字就创建几个按钮
    // 设置按钮frame
    CGFloat margin = 10; // 假设每个按钮之间的间距都是10
    CGFloat answerW = 35;
    CGFloat answerH = 35;
    CGFloat marginLeft = (self.view.frame.size.width - rowCount * answerW - (rowCount - 1) * margin)/2;
    
    for (int i = 0; i < words.count; i++) {
        UIButton *btnOpt = [[UIButton alloc] init];
        
        // 给每个option 按钮一个唯一的tag值
        btnOpt.tag = i;
        
        // 设置按钮背景
        [btnOpt setBackgroundColor:UIColor.whiteColor];
        [btnOpt setTitle:words[i] forState:UIControlStateNormal];
        [btnOpt setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        
        // 计算当前按钮的列的索引和行的索引
        int colidx = i % rowCount;
        int rowId = i / rowCount;
        
        CGFloat answerY = (answerH + margin) * rowId;
        CGFloat answerX = marginLeft + colidx * (answerW + margin);
        // 设置按钮frame
        btnOpt.frame = CGRectMake(answerX, answerY, answerW, answerH);
        
        // 把按钮加到answerView中
        [self.optionsView addSubview:btnOpt];
        
        // 为待选按钮注册单击事件
        [btnOpt addTarget:self action:@selector(optionButtonClick:)  forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}

// 待选按钮的单击事件
-(void)optionButtonClick:(UIButton *)sender {
    
        // 1. 隐藏当前被点击的按钮
        sender.hidden = YES;
    
    // 2. 把当前被点击的按钮的文字显示到第一个为空的”答案按钮“上
//    NSString *text = [sender titleForState:UIControlStateNormal];
    NSString *text = sender.currentTitle;  // 获取按钮当前状态下的文字
    
    // 2.1 把文字显示到 答案按钮上
    
    for (UIButton *answerBtn in self.answerView.subviews) {
        if (answerBtn.currentTitle == nil) {
            [answerBtn setTitle:text forState:UIControlStateNormal];
            // 给答案给一个 tag 标记，做清楚操作
            answerBtn.tag = sender.tag;
            break;
        }
    }
    
    /// 3 判断答案按钮是否已经填满了
    // 一开始假设答案按钮是填满的
    BOOL isFull = YES;
    // 声明一个用来保存用户输入的答案的字符串
    NSMutableString *userInput = [NSMutableString string];
    for (UIButton *answerBtn in self.answerView.subviews) {
        if (answerBtn.currentTitle == nil) {
            isFull = NO;
            break;
        } else {
            [userInput appendString:answerBtn.currentTitle];
        }
    }
    
    if (isFull) {
        // 禁止"待选按钮”被点击
        /// 3.1 如果填满了，就禁止按钮点击
        self.optionsView.userInteractionEnabled = NO;
        
        /// 3.2 如果填满了，判断答案是否正确
        /// 获取当前题目的正确答案
        CZQuestion *model =  self.questions[self.index];
        
        if ([userInput isEqualToString:model.answer]) {
            /// 3.2.1 答案正确，则设置按按按钮的文字颜色为蓝色，同时在0.5秒之后跳转进入下一题
            /// 加 100 分
            [self addScore:100];
            [self setAnswerButtonsTitleColot:UIColor.blueColor];
            // 延迟 0.5s
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
            
        } else {
            // 如果答案不一致（答案销误），设置答案按钮的文字颜色为红色
            // 设置所有的答案按钮的文字颜色方，红色
            [self setAnswerButtonsTitleColot:UIColor.redColor];
        }
    }
}

-(int)addScore:(int)score{
    // 1. 获取按钮上现在分值
    NSString *str = self.btnScore.currentTitle;
    // 2. 把这个分值转换成数字类型
    int currentScore = str.intValue;
    if (currentScore <= 0) {
        return currentScore;
    }
    // 3.对这个分数进行操作
    currentScore = currentScore + score;
    // 4.把新的分数设置给按钮
    [self.btnScore setTitle:[NSString stringWithFormat:@"%d",currentScore] forState:UIControlStateNormal];
    return currentScore;
}

// 统一设置答案按钮的文字颜色
-(void)setAnswerButtonsTitleColot:(UIColor *)color{
    for (UIButton *answerBtn in self.answerView.subviews) {
        [answerBtn setTitleColor:color forState:UIControlStateNormal];
    }
}



-(IBAction)btnIconClicked{
    if (self.cover == nil) {
        [self bigImageClicked];
    } else {
        [self btnCoverClicked];
    }
}

-(IBAction)bigImageClicked{
    // 记录 图片原始 frame
    self.iconFrame = self.btnIcon.frame;
    
    // 1. 创建大小与self,view一样的按钮，把这个按钮作为一个"阴影“
    UIButton *btnCover = [[UIButton alloc] init];
    btnCover.frame = self.view.bounds;
    btnCover.backgroundColor = UIColor.blackColor;
    btnCover.alpha =  0.0;
    
    [self.view addSubview:btnCover];
    // 为阴影按钮注册一个单击事件
    [btnCover addTarget:self action:@selector(btnCoverClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // 2. 把图片设置到阴影的上面
    // 把self.view中的所有子控件中，只把self.btnIcon显示到最上层
    [self.view bringSubviewToFront:self.btnIcon];
    self.cover = btnCover;
    
    // 设置图片大小和位置
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconH) * 0.5 ;
    
    // 3. 通过动画的方式把图片变大
    [UIView animateWithDuration:0.7 animations:^{
        btnCover.alpha =  0.6;
        self.btnIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];
    
}


-(void)btnCoverClicked{
    [UIView animateWithDuration:0.7 animations:^{
        // 设置btnlcon（头像）按钮的frame还原
        self.btnIcon.frame = self.iconFrame;
        
        // 2.让”阴影“按钮的透明度变成0
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            // 3.移出"阴影"按钮
            [self.cover removeFromSuperview];
            // 当头像图片变成小图以后，再把self.cover设置成nil/
            self.cover = nil;
        }
        
    }];
    
}

- (IBAction)scroll:(UIButton *)sender {
}
@end
