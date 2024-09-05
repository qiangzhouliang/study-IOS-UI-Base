//
//  ViewController.m
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import "ViewController.h"
#import "CZGoods.h"
#import "CZGoodsCell.h"
#import "CZFooterView.h"
#import "CZHeaderView.h"


@interface ViewController () <UITableViewDataSource,UITableViewDelegate, CZFooterViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 用来存储所以的商品信息
@property (nonatomic, strong) NSMutableArray *goods;

@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSMutableArray *)goods{
    if (_goods == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *arrDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrModels = [NSMutableArray array];
        for (NSDictionary *dict in arrDict) {
            CZGoods *model = [CZGoods goodsWithDict:dict];
            [arrModels addObject:model];
        }
        _goods = arrModels;
    }
    
    return _goods;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置Tableview行高
    self.tableView.rowHeight = 60;
    
    // 通过xib设置UITableView的footview
    CZFooterView *footView = [CZFooterView footerView];
    // 设置代理
    footView.delegate = self;
    self.tableView.tableFooterView = footView;
    
    // 创建HeaderView
    CZHeaderView *headerView = [CZHeaderView headerView];
    headerView.imgs = @[@"banner1",@"banner2",@"banner3"];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - 数据源方法
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

/// 有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

/// 返回cell 条目
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1. 获取模型数据
    CZGoods *model = self.goods[indexPath.row];
    
    // 2. 创建单元格
    {
//        static NSString *ID = @"goods_cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        }
    }
    
    // 通过xib方式创建单元格
    CZGoodsCell *cell = [CZGoodsCell goodsCellWithTableView:tableView];
    
    // 3. 设置数据
    cell.goods = model;
    
    // 4.返回单元格
    return cell;
}


#pragma mark - CZFootView的代理方法
- (void)footerViewUpdateData:(CZFooterView *)footerView{
    // 新增一条数据并刷新页面
    CZGoods *model = [CZGoods new];
    model.title = @"卤肉活少";
    model.price = @"9.0";
    model.buyCount = @"1000";
    model.icon = @"icon-ppt";
    
    [self.goods addObject:model];
    [self.tableView reloadData];
    
    // 把UITableView中的最后一行的数据滚动到最上面
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.goods.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
