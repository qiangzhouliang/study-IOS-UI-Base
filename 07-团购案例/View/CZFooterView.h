//
//  CZFooterView.h
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import <UIKit/UIKit.h>

@class CZGoods;

NS_ASSUME_NONNULL_BEGIN

@class CZFooterView;
@protocol CZFooterViewDelegate <NSObject, UIScrollViewDelegate>

@required
-(void) footerViewUpdateData:(CZFooterView *)footerView;

@end


@interface CZFooterView : UIView

@property (nonatomic, weak) id<CZFooterViewDelegate> delegate;

+ (instancetype) footerView;

@end

NS_ASSUME_NONNULL_END
