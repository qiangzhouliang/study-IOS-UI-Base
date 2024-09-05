//
//  CZQQFriendsTableViewController.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import "CZQQFriendsTableViewController.h"
#import "CZFriendCell.h"
#import "CZGroupHeaderView.h"

@interface CZQQFriendsTableViewController () <UITableViewDataSource, UITableViewDelegate, CZGroupHeaderViewDelegate>

// 保存所有的朋友信息（分组信息）
@property (nonatomic, strong) NSArray *groups;


@end

@implementation CZQQFriendsTableViewController

#pragma mark - ********懒加载********
- (NSArray *)groups{
    if (_groups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        NSArray *arrDicts = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        for (NSDictionary *dict in arrDicts) {
            CZGroupFriend *group = [CZGroupFriend groupWithDict:dict];
            [arrayModels addObject:group];
        }
        _groups = arrayModels;
    }
    return _groups;
}

#pragma mark -*控制器的viewDidLoad方法*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 解决顶部多出一截问题
    self.tableView.sectionHeaderTopPadding = 0;
    
    // 统一设置每组的组标题的高度
    self.tableView.sectionHeaderHeight = 60;
}

#pragma mark - 实现数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

// 每一组由多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CZGroupFriend *group = self.groups[section];
    if (group.isVisible) {
        return group.friends.count;
    } else {
        return 0;
    }
    
}

// 返回要展示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZGroupFriend *group = self.groups[indexPath.section];
    CZFriend *friend = group.friends[indexPath.row];
    
    CZFriendCell *cell = [CZFriendCell friendCellWithTableView:tableView];
    cell.friendModel = friend;
    
    return cell;
}

// 返回组标题(下面的这个方法只能设置每一组的组标题字符串，但是我们要的是每一组中还包含其他子控件)
//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    CZGroupFriend *group = self.groups[section];
//    return group.name;
//}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 不要在这个方法中直接创建一个UIView对象返回，因为这样无法实现重用该UIView
    // 为了能重用每个Header中的UIView，所以这里要返回一个UITableViewHeaderFooterView
    // 1. 获取模型数据
    CZGroupFriend *group = self.groups[section];
    // 2. 创建UITableViewHeaderFooterView
    CZGroupHeaderView *headerVw = [CZGroupHeaderView groupHeaderViewWithTableView:tableView];
    
    // 3. 设置数据
    headerVw.group = group;
    headerVw.tag = section;
    
    // 设置代理
    headerVw.delegate = self;
    
    // 4. 返回 view
    return headerVw;
}

#pragma mark - 组标题按钮代理方法
- (void)groupHeaderViewDidClickTitleButton:(nonnull CZGroupHeaderView *)groupHeaderView {
    // 刷新数据
//    [self.tableView reloadData];
    // 局部刷新
    NSIndexSet *idSet = [NSIndexSet indexSetWithIndex:groupHeaderView.tag];
    [self.tableView reloadSections:idSet withRowAnimation:UITableViewRowAnimationFade];
}

@end
