//
//  NSString+CZNSStringExt.h
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CZNSStringExt)

- (CGSize) sizeOfTextWithMaxSize: (CGSize)maxSzie andFont: (UIFont *)font;

+ (CGSize) sizeWithText: (NSString *)text andMaxSize: (CGSize)maxSzie andFont: (UIFont *)font;

@end

NS_ASSUME_NONNULL_END
