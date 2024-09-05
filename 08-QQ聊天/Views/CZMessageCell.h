//
//  CZMessageCell.h
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import <UIKit/UIKit.h>
#import "CZMessageFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZMessageCell : UITableViewCell

@property (nonatomic, strong) CZMessageFrame *messageFrame;


+ (instancetype) messageCellWithTableView: (UITableView *) tableView;

@end

NS_ASSUME_NONNULL_END
