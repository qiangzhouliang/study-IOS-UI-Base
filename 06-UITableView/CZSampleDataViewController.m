/*
 1. 为UITableView设置数据源对象
 2．让数据源对象遵守UITableViewDataSource协议
 3. 在数据源对象中实现UITableViewDataSource协议的方法（一般情况下会实现3个方法）
 
 
 
 
 */

#import "CZSampleDataViewController.h"

@interface CZSampleDataViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CZSampleDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置数据源的2种方式
    // 1> 代码 方式
    self.tableView.dataSource = self;
    // 2> 拖线 方式
}

#pragma mark - /****************UITableView数据源方法***********************/
// 1. 告诉 UITableView 要显示几组
// 这个方法可以不实现，不实现默认就是分1组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // 要展示三组数据（亚洲、非洲、欧洲）
    return 3;
}

// 2. 告诉UITableView每组显示几行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 根据不同的组返回每组显示不同的数据
    switch (section) {
        case 0:
            return 3; // 亚洲
        case 1:
            return 2; // 非洲
        default:
            return 1;
    }
}


// 3. 告诉 UITableView 每一组的每一行显示什么数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 创建一个单元格对象并返回
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 为单元格指定数据
            cell.textLabel.text = @"中国";
        } else if (indexPath.row == 1) {
            // 为单元格指定数据
            cell.textLabel.text = @"日本";
        } else {
            // 为单元格指定数据
            cell.textLabel.text = @"韩国";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // 为单元格指定数据
            cell.textLabel.text = @"南非";
        } else {
            // 为单元格指定数据
            cell.textLabel.text = @"索马里";
        }
    } else {
        // 为单元格指定数据
        cell.textLabel.text = @"荷兰";
    }
    
    return cell;
}


// 4. 每一组的组标题是什么
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 根据当前组的索引section，返回不同组的标题
    switch (section) {
        case 0:
            return @"亚洲"; // 亚洲
        case 1:
            return @"非洲"; // 非洲
        default:
            return @"欧洲";
    }
}


// 5. 每一组的”组尾“（组描述）
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    // 根据当前组的索引section，返回不同组的描述信息
    switch (section) {
        case 0:
            return @"亚细亚周，日出的地方"; // 亚洲
        case 1:
            return @"阿里非加州，阳光灼热的地方"; // 非洲
        default:
            return @"欧罗巴洲，鲜花盛开的地成日落的地方";
    }
}
/****************UITableView数据源方法***********************/


@end
