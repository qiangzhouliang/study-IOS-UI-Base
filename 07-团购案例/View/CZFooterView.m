//
//  CZFooterView.m
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import "CZFooterView.h"
#import "CZGoods.h"

@interface CZFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet UIView *waitingView;
- (IBAction)btnLoadMoreClick:(UIButton *)sender;

@end

@implementation CZFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/// 加载更多按钮的单击事件
- (IBAction)btnLoadMoreClick:(UIButton *)sender {
    // 1. 隐藏“加载更多"按钮
    self.btnLoadMore.hidden = YES;
    
    // 2. 显示”等待指示器“所在的按个UIView
    self.waitingView.hidden = NO;
    
    // 延迟1s后执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 3. 调用代理方法实现下面的功能
        //调用footerViewUpdateData方法之前，为了保证调用不出错，所以要先判断一下代理对象是否真的实现了这个方法，如果实现了这个方法再调用，否则不调用。
        if ([self.delegate respondsToSelector:@selector(footerViewUpdateData:)]) {
            // 3. 增加一条数据
            
            // 4. 刷新UITableView
            [self.delegate footerViewUpdateData:self];
        }
        // 4. 隐藏“加载更多"按钮
        self.btnLoadMore.hidden = NO;
        
        // 5. 显示”等待指示器“所在的按个UIView
        self.waitingView.hidden = YES;
    });
    
    
    
}

/// 初始化加载 footerView
+ (instancetype) footerView{
    CZFooterView *footView = [[NSBundle mainBundle] loadNibNamed:@"CZFooterView" owner:nil options:nil].firstObject;
    return footView;
}
@end

