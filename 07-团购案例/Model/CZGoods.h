//
//  CZGoods.h
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZGoods : NSObject

@property(nonatomic, copy)NSString *buyCount;
@property(nonatomic, copy)NSString *price;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)goodsWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
