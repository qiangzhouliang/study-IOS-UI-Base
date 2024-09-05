//
//  CZMessageCell.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/4.
//

#import "CZMessageCell.h"


@interface CZMessageCell ()
@property (nonatomic, weak) UILabel *lblTime;
@property (nonatomic, weak) UIImageView *imgViewIcon;
@property (nonatomic, weak) UIButton *textBtn;

@end

@implementation CZMessageCell

#pragma mark - 重写initWithStyle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建子控件
        // 显示时间的label
        UILabel *lblTime = [[UILabel alloc] init];
        // 设置文字大小
        lblTime.font = [UIFont systemFontOfSize:12];
        // 设置文字居中
        lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
        
        // 显示头像 UIImageView
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        // 显示正文的按钮
        UIButton *textBtn = [[UIButton alloc] init];
        // 设置正文字体大小
        textBtn.titleLabel.font = textFont;
        // 设置换行
        textBtn.titleLabel.numberOfLines = 0;
        // 设置 titleLabel 设置内边距

//        textBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        UIButtonConfiguration *config = textBtn.configuration;
        config.contentInsets = NSDirectionalEdgeInsetsMake(15, 20, 15, 20);
        textBtn.configuration = config;
        // 设置圆角
        textBtn.layer.cornerRadius = 5;
        [self.contentView addSubview:textBtn];
        self.textBtn = textBtn;
    }
    // 设置单元格的背景色
    self.backgroundColor = [UIColor clearColor];
    return self;
}

+ (instancetype)messageCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"message_cell";
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CZMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 重写frame模型的set方法
- (void)setMessageFrame:(CZMessageFrame *)messageFrame{
    _messageFrame = messageFrame;
    // 分别设置每个子控件的数据 和 frame
    CZMessage *message = messageFrame.message;
    // 设置时间
    self.lblTime.text = message.time;
    
    self.lblTime.frame = messageFrame.timeFrame;
    self.lblTime.hidden = message.hideTime;
    
    // 设置头像
    // 根据消息类型，判断应该使用哪张图片
    NSString *iconImg = message.type == CZMessageTypeMe ? @"icon-word" : @"icon-ppt";
    self.imgViewIcon.image = [UIImage imageNamed:iconImg];
    self.imgViewIcon.frame = messageFrame.iconFrame;
    
    // 设置正文
    [self.textBtn setTitle:message.text forState:UIControlStateNormal];
    if (message.type == CZMessageTypeMe) {
        // 设置背景
        [self.textBtn setBackgroundColor: UIColor.blueColor];
        [self.textBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        // 设置背景
        [self.textBtn setBackgroundColor: UIColor.whiteColor ];
        [self.textBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }
    
    
    
    self.textBtn.frame = messageFrame.textFrame;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
