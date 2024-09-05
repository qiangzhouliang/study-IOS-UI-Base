//
//  CZGroup.h
//  06-UITableView
//
//  Created by swan on 2024/9/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZGroup : NSObject
// 组标题
@property(nonatomic, copy)NSString *title;
// 组描述
@property(nonatomic, copy)NSString *desc;
// 这组里面的汽车品牌信息
@property(nonatomic, strong)NSMutableArray *cars;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
