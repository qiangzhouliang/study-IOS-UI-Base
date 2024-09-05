//
//  CZMessageFrame.h
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import <Foundation/Foundation.h>
#import "CZMessage.h"
#import "NSString+CZNSStringExt.h"

#define textFont [UIFont systemFontOfSize:14]

NS_ASSUME_NONNULL_BEGIN

@interface CZMessageFrame : NSObject

// 引用数据模型
@property (nonatomic, strong) CZMessage *message;

// 时间 Label 的frame
@property (nonatomic, assign, readonly) CGRect timeFrame;

// 头像 的frame
@property (nonatomic, assign, readonly) CGRect iconFrame;

// 内容 的frame
@property (nonatomic, assign, readonly) CGRect textFrame;

// 行高
@property (nonatomic, assign, readonly) CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
