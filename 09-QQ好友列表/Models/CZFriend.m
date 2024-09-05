//
//  CZFriend.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import "CZFriend.h"

@implementation CZFriend

- (instancetype) initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype) friendWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
