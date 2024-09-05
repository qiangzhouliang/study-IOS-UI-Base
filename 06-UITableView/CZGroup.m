//
//  CZGroup.m
//  06-UITableView
//
//  Created by swan on 2024/9/2.
//

#import "CZGroup.h"

@implementation CZGroup
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self == [super init]) {
//        self.title = dict[@"title"];
//        self.desc = dict[@"desc"];
//        self.cars = dict[@"cars"];
        
        // KVC
        [self setValuesForKeysWithDictionary: dict];
    }
    return self;
}


+ (instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
