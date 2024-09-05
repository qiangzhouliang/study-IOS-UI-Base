//
//  CZGroup.h
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZGroupFriend : NSObject

// 组名
@property (nonatomic, copy) NSString *name;

// 在线人数
@property (nonatomic, assign) int online;

// 当前组中的所有的好友数据
@property (nonatomic, strong) NSArray *friends;

// 表示这个组是否可见
@property (nonatomic, assign, getter=isVisible) BOOL visible;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) groupWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
