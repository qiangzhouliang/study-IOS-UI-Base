//
//  CZMessage.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import "CZMessage.h"

@implementation CZMessage


- (instancetype)initWithDict: (NSDictionary *)dict{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
