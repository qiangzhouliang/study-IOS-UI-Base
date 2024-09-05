//
//  CZApp.m
//  03-应用管理
//
//  Created by swan on 2024/8/29.
//

#import "CZApp.h"

@implementation CZApp

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}

+ (instancetype)appWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
