//
//  CZPListDataViewController.m
//  06-UITableView
//
//  Created by swan on 2024/9/2.
//

#import "CZPListDataViewController.h"
#import "CZGroup.h"

@interface CZPListDataViewController () <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)NSArray *groups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CZPListDataViewController

#pragma mark - 懒加载数据
- (NSArray *)groups{
    if (_groups == nil) {
        // 懒加载数据
        // 找到plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_simple" ofType:@"plist"];
        // 加载plist文件
        NSArray *arrDict = [NSArray arrayWithContentsOfFile:path];
        // 把字典转成模型
        NSMutableArray *arrayModel = [NSMutableArray array];
        for (NSArray *dict in arrDict) {
            CZGroup *model = [CZGroup groupWithDict: dict];
            [arrayModel addObject:model];
        }
        
        _groups = arrayModel;
    }
    return _groups;
}

#pragma mark - 页面加载成功
- (void)viewDidLoad {
    [super viewDidLoad];
    // 统一设置UITableView的所有行的行高
    // 如果每行的行高是一样的，那么通过rowHeight统一设置行高效率更高
    // 对于每行的行高不一样的情况，无法通过tableView.rowHeight来实现
    // 此时，只能通过一个代理方法来实现。
    self.tableView.rowHeight = 60;
    
    // 设置分割线的颜色
    self.tableView.separatorColor = [UIColor redColor];
    // 设置分割线的样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
}

#pragma mark - /****************UITableView数据源方法***********************/
// 1. 告诉 UITableView 要显示几组
// 这个方法可以不实现，不实现默认就是分1组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // 要展示三组数据（亚洲、非洲、欧洲）
    return self.groups.count;
}

// 2. 告诉UITableView每组显示几行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 根据不同的组返回每组显示不同的数据
    CZGroup *group = self.groups[section];
    return group.cars.count;
}


// 3. 告诉 UITableView 每一组的每一行显示什么数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CZGroup *group = self.groups[indexPath.section];
    
    // 创建一个单元格对象并返回
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    // 因为每次都创建一个单元格效率比较低，所以要对单元格进行重用。
    // 单元格重用的基本思路就是：
    // 1> 在创建单元格的时候指定一个"重用ID"
    // 2> 当需要一个新的单元格的时候，先去“缓存池”中根据”重用ID”去查找是否有可用的单元格
    // ** 如果有，则直接从缓存池中取出这个单元格，进行使用（修改这个单元格中显示的数据、样式）
    // ** 如果没有需要的单元格，此时只能重新创建件一个单元格了。
    // 声明一个重用id
    NSString *ID = @"car_cell";
    
    // 根据这个重用ID去“缓存池“中查找对应的Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSLog(@"新创建一个cell");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: ID];
    }
    
    cell.textLabel.text = group.cars[indexPath.row];
    
    
    // 要在单元格的最右边显示一个小箭头，所以要设置单元格对象的某个属性
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    cell.accessoryView = [[UISwitch alloc] init];
    
    // --------------------------设置单元格背景-----------------------
    // 设置单元格背景颜色
//    if (indexPath.row % 2 == 0) {
//        cell.backgroundColor = [UIColor blueColor];
//    } else {
//        cell.backgroundColor = [UIColor purpleColor];
//    }
//    
//    // 设置单元格选中时的背景颜色
//    UIView *bgView = [[UIView alloc] init];
//    bgView.backgroundColor = [UIColor greenColor];
//    cell.selectedBackgroundView = bgView;
    // --------------------------设置单元格背景-----------------------
    
    
    return cell;
}


// 4. 每一组的组标题是什么
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 根据当前组的索引section，返回不同组的标题
    CZGroup *group = self.groups[section];
    return group.title;
}


// 5. 每一组的”组尾“（组描述）
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    // 根据当前组的索引section，返回不同组的描述信息
    CZGroup *group = self.groups[section];
    return group.desc;
}

// 6 设置UITableView右侧的索引栏
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return @[@"你",@"我"];
    return [self.groups valueForKey:@"title"];
}



/****************UITableView数据源方法***********************/

#pragma mark - 代理方法
// 设置特定行的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    int rowNum = indexPath.row;
//    if (rowNum % 2 == 0) {
//        return 60;
//    } else {
//        return 100;
//    }
//}

// 监听行被选中的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取当前被选中行的汽车名称
    CZGroup *groups = self.groups[indexPath.section];
    
    // 弹出一个对话框
    UIAlertController *toast = [UIAlertController alertControllerWithTitle:@"修改汽车" message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 添加编辑框
    [toast addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = groups.cars[indexPath.row];
    }];
    
    // 创建UIAlertAction，用于处理按钮点击事件
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [toast dismissViewControllerAnimated:true completion:nil];
        UITextField *textField = toast.textFields.firstObject;
        NSLog(@"输入的内容是：%@", textField.text);
        // 修改数据
        NSMutableArray *arr = [NSMutableArray arrayWithArray:groups.cars];
        [arr replaceObjectAtIndex:indexPath.row withObject:textField.text];
        groups.cars = arr;
        // 刷新数据
        [self.tableView reloadData];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [toast dismissViewControllerAnimated:true completion:nil];
    }];
    // 将UIAlertAction添加到UIAlertController
    [toast addAction:cancleAction];
    [toast addAction:alertAction];
    // 获取当前视图控制器显示弹框
    [self presentViewController:toast animated:true completion:nil];
    
}

@end
