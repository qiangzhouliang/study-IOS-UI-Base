//
//  CZGoodsCell.h
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import <UIKit/UIKit.h>

@class CZGoods;

NS_ASSUME_NONNULL_BEGIN

@interface CZGoodsCell : UITableViewCell

@property (nonatomic, strong) CZGoods *goods;

// // 封装一个创建自定义CeLl的方法
+ (instancetype) goodsCellWithTableView: (UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
