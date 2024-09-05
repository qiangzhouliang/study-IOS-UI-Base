//
//  CZGoodsCell.m
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import "CZGoodsCell.h"
#import "CZGoods.h"

@interface CZGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbBuyCount;


@end

@implementation CZGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 设置数据
- (void)setGoods:(CZGoods *)goods{
    self.imgViewIcon.image = [UIImage imageNamed:goods.icon];
    self.lbTitle.text = goods.title;
    self.lbPrice.text = [NSString stringWithFormat:@"￥  %@",goods.price];
    self.lbBuyCount.text = [NSString stringWithFormat:@"%@ 人购买",goods.buyCount];
}

#pragma mark - 封装一个创建自定义CeLl的方法
+ (instancetype) goodsCellWithTableView: (UITableView *)tableView{
    static NSString *ID = @"goods_cell";
    CZGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CZGoodsCell" owner:nil options:nil].firstObject;
    }
    return cell;
}

@end
