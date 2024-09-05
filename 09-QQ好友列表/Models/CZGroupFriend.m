//
//  CZGroup.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import "CZGroupFriend.h"
#import "CZFriend.h"

@implementation CZGroupFriend

- (instancetype) initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
        // 把 self.friends 由字典数组转换为模型数组
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict_sub in self.friends) {
            CZFriend *model = [CZFriend friendWithDict:dict_sub];
            [arrayModels addObject:model];
        }
        self.friends = arrayModels;
    }
    return self;
}

+ (instancetype) groupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
