//
//  CZMessageFrame.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import "CZMessageFrame.h"
#import "UIKit/UIKit.h"

@implementation CZMessageFrame

- (void)setMessage:(CZMessage *)message{
    _message = message;
    
    // 计算每个控件的 frame 和 行高
    // 获取屏幕匡高
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 设置统一的间距
    CGFloat margin = 10;
    
    // 时间
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 15;
    if (!message.hideTime) {
        _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    // 头像
    CGFloat imgIconW = 30;
    CGFloat imgIconH = 30;
    CGFloat imgIconX = message.type == CZMessageTypeOther ? margin : screenW - margin - imgIconW;
    CGFloat imgIconY = CGRectGetMaxY(_timeFrame) + margin;
    _iconFrame = CGRectMake(imgIconX, imgIconY, imgIconW, imgIconH);
    // 正文
    CGSize textSzie = [message.text sizeOfTextWithMaxSize:CGSizeMake(200, MAXFLOAT) andFont:textFont];
    CGFloat textW = textSzie.width + 40;
    CGFloat textH = textSzie.height + 30;
    CGFloat textX = message.type == CZMessageTypeOther ? CGRectGetMaxX(_iconFrame) : screenW - margin - imgIconW - textW;
    CGFloat textY = imgIconY;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    // 行高
    // 获取 头像的最大的Y值和正文的最大的Y值，然后用最大的Y值+ margin
    CGFloat maxY = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight = maxY + margin;
}

@end
