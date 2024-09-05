//
//  CZQuestion.m
//  04-超级猜图
//
//  Created by swan on 2024/8/30.
//

#import "CZQuestion.h"

@implementation CZQuestion

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        self.answer = dict[@"answer"];
        self.title = dict[@"title" ];
        self.icon = dict[@"icon"];
        self.options = dict[@"options"];
    }
    return self;
}

+ (instancetype)questionWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
