//
//  CZQuestion.h
//  04-超级猜图
//
//  Created by swan on 2024/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZQuestion : NSObject

@property(nonatomic, copy)NSString *answer;
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)NSArray *options;

- (instancetype)initWithDict: (NSDictionary *)dict;
+ (instancetype)questionWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
