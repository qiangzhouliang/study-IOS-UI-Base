//
//  CZGoods.m
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import "CZGoods.h"

@implementation CZGoods

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict;{
    return [[self alloc] initWithDict:dict];
}

@end
