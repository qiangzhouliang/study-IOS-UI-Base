//
//  NSString+CZNSStringExt.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import "NSString+CZNSStringExt.h"

@implementation NSString (CZNSStringExt)

- (CGSize) sizeOfTextWithMaxSize: (CGSize)maxSzie andFont: (UIFont *)font{
    NSDictionary *attrs = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSzie options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize) sizeWithText: (NSString *)text andMaxSize: (CGSize)maxSzie andFont: (UIFont *)font{
    return [text sizeOfTextWithMaxSize:maxSzie andFont:font];
}

@end
