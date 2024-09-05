//
//  ViewController.m
//  03-应用管理
//
//  Created by swan on 2024/8/29.
//

#import "ViewController.h"
#import "CZApp.h"

@interface ViewController ()

// 用来保存应用程序数据
@property(nonatomic, strong)NSArray *apps;

- (IBAction)btnNextClicked;
- (IBAction)brnNextClicked;
- (IBAction)btnNext:(UIButton *)sender;
@end

@implementation ViewController
// 重写apps属性的get方法，进行懒加载数据
- (IBAction)btnNext:(UIButton *)sender {
}

- (IBAction)brnNextClicked {
}

- (IBAction)btnNextClicked {
}

- (NSArray *)apps{
    if (_apps == nil) {
        // 加载数据
        // 1. 获取app.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"];
        
        // 2. 根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        // 3 创建一个可变数组来保存一个一个的模型对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        // 4. 循环字典数组，把每个字典对象转换成一个模型对象
        for (NSDictionary *dict in arrayDict) {
            // 创建一个模型
//            CZApp *app = [CZApp new];
//            app.icon = dict[@"icon"];
//            app.name = dict[@"name"];
            
            CZApp *app = [CZApp appWithDict:dict];
            // 把模型加到可变数组里面
            [arrayModels addObject:app];
        }
        _apps = arrayModels;
        
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 假设每行的应用的个数
    int colums = 3;
    // 获取控制器所管理的view的宽度
    CGFloat viewWidth = self.view.frame.size.width;
    // 每个appView的宽和高
    CGFloat appW = 75;
    CGFloat appH = 90;
    CGFloat MarginTop = 80; // 第一行距离顶部的距离
    CGFloat MarginX = (viewWidth - colums * appW)/(colums + 1);
    CGFloat MarginY = MarginX;// 假设每行 之间的间距与Marginx 相等
    
    for (int i = 0; i < self.apps.count; i++) {
        // 获取当前这个应用的数据字典
        CZApp *appModel = self.apps[i];
        
        // 1. 创建每个应用（UIView）
        UIView *appView = [[UIView alloc] init];
        
        // 2. 设置appView的属性
        // 2.1 设置 appView 的背景色
//        appView.backgroundColor = UIColor.blueColor;
        // 2.2 设置 APPView的frame属性
        // 计算每个单元格的行列索引
        int colIndex = i % colums;
        int rowIndex = i / colums;
        
        CGFloat appX = MarginX + (appW + MarginX) * colIndex;
        CGFloat appY = MarginTop + (appH + MarginY) * rowIndex;
        appView.frame = CGRectMake(appX, appY, appW, appH);
        
        // 3. 将appView加到self.view（控制器所管理的那个view）
        [self.view addSubview:appView];
        
        // 4. 向UIView中增加子控件
        // 4.1 增加一个图片框
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
//        imgViewIcon.backgroundColor = UIColor.yellowColor;
        CGFloat iconW = 45;
        CGFloat iconH = 45;
        CGFloat iconX = (appView.frame.size.width - iconW) * 0.5;
        CGFloat iconY = 0;
        imgViewIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        [appView addSubview:imgViewIcon];
        // 设置图片框数据
        imgViewIcon.image = [UIImage imageNamed:appModel.icon];
        
        // 4.2 增加一个label
        UILabel *labelName = [[UILabel alloc] init];
//        labelName.backgroundColor = UIColor.redColor;
        CGFloat nameW = appView.frame.size.width;
        CGFloat nameH = 20;
        CGFloat nameX = 0;
        CGFloat nameY = iconH;
        labelName.frame = CGRectMake(nameX, nameY, nameW, nameH);
        [appView addSubview:labelName];
        // 设置label数据
        labelName.text = appModel.name;
        // 设置字体大小
        labelName.font = [UIFont systemFontOfSize:12];
        // 设置对齐方式
        labelName.textAlignment = NSTextAlignmentCenter;
        
        // 4.3 增加一个UIButton
        UIButton *btnDownload = [[UIButton alloc] init];
        CGFloat downloadW = iconW;
        CGFloat downloadH = 20;
        CGFloat downloadX = iconX;
//        CGFloat downloadY = nameY + nameH ;
        CGFloat downloadY = CGRectGetMaxY(labelName.frame);
        btnDownload.frame = CGRectMake(downloadX, downloadY, downloadW, downloadH);
        [appView addSubview:btnDownload];
        // 补充：控件的最大的Y值= 控件的Y值 + 控件的高度
        // 控件的最大的X值= 控件的X值+ 控件的宽度
        
        // 设置button按钮数据
        // 设置按钮的文字
        [btnDownload setTitle:@"下载" forState:UIControlStateNormal];
        [btnDownload setTitle:@"已安装" forState:UIControlStateDisabled];
        // 设置按钮背景
        btnDownload.backgroundColor = UIColor.blueColor;
        // 设置按钮文字大小
        btnDownload.titleLabel.font = [UIFont systemFontOfSize:12];
        
        // 设置按钮单击事件
        [btnDownload addTarget:self action:@selector(btnDownloadClicked) forControlEvents: UIControlEventTouchUpInside];
        
    }
    
}

- (void)btnDownloadClicked{
    NSLog(@"我被点击了");
}
@end
