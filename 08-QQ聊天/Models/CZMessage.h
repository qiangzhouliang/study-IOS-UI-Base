//
//  CZMessage.h
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import <Foundation/Foundation.h>

typedef enum {
    CZMessageTypeMe = 0,  // 表示自己
    CZMessageTypeOther = 1// 表示对方
}CZMessageType;

NS_ASSUME_NONNULL_BEGIN

@interface CZMessage : NSObject

// 消息正文
@property (nonatomic, copy) NSString *text;

// 消息发送时间
@property (nonatomic, copy) NSString *time;

// 消息类型
@property (nonatomic, assign) CZMessageType type;

// 记录是否需要显示时间
@property (nonatomic, assign) BOOL *hideTime;




- (instancetype)initWithDict: (NSDictionary *)dict;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
