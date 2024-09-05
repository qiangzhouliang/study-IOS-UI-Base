//
//  CZApp.h
//  03-应用管理
//
//  Created by swan on 2024/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CZApp : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *icon;

//+(void) appWithDict(NSDictionary )dict;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)appWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
