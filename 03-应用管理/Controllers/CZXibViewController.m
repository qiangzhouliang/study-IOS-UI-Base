//
//  CZXibViewController.m
//  03-应用管理
// 使用 xib 自定义控件方式实现
//  Created by swan on 2024/8/29.
//

#import "CZXibViewController.h"
#import "CZApp.h"
#import "CZAppView.h"

@interface CZXibViewController ()

// 用来保存应用程序数据
@property(nonatomic, strong)NSArray *apps;

@end

@implementation CZXibViewController

// 重写apps属性的get方法，进行懒加载数据
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
        
        CZAppView *appView = [CZAppView appView];
        
        // 2. 设置appView的属性
        // 2.2 设置 APPView的frame属性
        // 计算每个单元格的行列索引
        int colIndex = i % colums;
        int rowIndex = i / colums;
        
        CGFloat appX = MarginX + (appW + MarginX) * colIndex;
        CGFloat appY = MarginTop + (appH + MarginY) * rowIndex;
        appView.frame = CGRectMake(appX, appY, appW, appH);
        
        // 3. 将appView加到self.view（控制器所管理的那个view）
        [self.view addSubview:appView];
        
        // 4 设置APPView里面的数据
//        NSArray<UIView *> *arrayView = [appView subviews];
//        ((UIImageView *)arrayView[0]).image = [UIImage imageNamed:appModel.icon];
//        ((UILabel *)arrayView[1]).text = appModel.name;
//        [((UIButton *)arrayView[2]) addTarget:self action:@selector(btnDownloadClicked) forControlEvents:UIControlEventTouchUpInside];
        
//        ----------------------
//        appView.imgViewIcon.image = [UIImage imageNamed:appModel.icon];
//        appView.lblName.text = appModel.name;
//        [appView.btnDownload addTarget:self action:@selector(btnDownloadClicked) forControlEvents:UIControlEventTouchUpInside];
        
//        -----------------
        appView.model = appModel;
        
    }
    
}


@end
