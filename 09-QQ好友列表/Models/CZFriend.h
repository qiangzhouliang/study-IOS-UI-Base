//
//  CZFriend.h
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZFriend : NSObject

// 头像
@property (nonatomic, copy) NSString *icon;
// 昵称
@property (nonatomic, copy) NSString *name;

// 个性签名
@property (nonatomic, copy) NSString *intro;

// 是否是VIP
@property (nonatomic, assign, getter=isVip) BOOL vip;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) friendWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
