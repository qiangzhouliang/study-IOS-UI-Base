//
//  CZAppView.h
//  03-应用管理
//
//  Created by swan on 2024/8/29.
//

#import <UIKit/UIKit.h>
#import "CZApp.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAppView : UIView

@property(nonatomic,strong)CZApp *model;

/// 为自定义View封装一个类方法
+ (instancetype)appView;

@end

NS_ASSUME_NONNULL_END
