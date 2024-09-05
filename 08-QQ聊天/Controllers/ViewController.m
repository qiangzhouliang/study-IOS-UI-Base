//
//  ViewController.m
//  08-QQ聊天
//
//  Created by swan on 2024/9/3.
//

#import "ViewController.h"
#import "CZMessageFrame.h"
#import "CZMessageCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

// 用来保存所有的消息的frame模型对象
@property (nonatomic, strong) NSMutableArray *messageFrames;

@end

@implementation ViewController

#pragma mark - /*****************懒加载数据**********************/
- (NSMutableArray *)messageFrames{
    if (_messageFrames == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        for (NSDictionary *dict in arrDict) {
            CZMessage *model = [CZMessage messageWithDict:dict];
            // 获取上一个模型
            CZMessage *lastMessage = (CZMessage *)[[arrayModels lastObject] message];
            //判断当前模型的“消息发送时间”是否和上一个模型的”消息发送时间”一致，如果一致做个标记
            if ([model.time isEqualToString: lastMessage.time]) {
                model.hideTime = YES;
            }
            
            CZMessageFrame *modelFrame = [CZMessageFrame new];
            modelFrame.message = model;
            
            
            
            [arrayModels addObject:modelFrame];
        }
        _messageFrames = arrayModels;
    }
    return _messageFrames;
}


#pragma mark - /*****************其他**********************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*********设置Tableview**************/
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    // 设置Tableview不能被选中
    self.tableView.allowsSelection = NO;
    
    /*********设置UITextField**************/
    // 设置文本框距离左侧有一定间距
    UIView *leftVw = [[UIView alloc] init];
    leftVw.frame = CGRectMake(0, 0, 5, 1);
    // 把 leftVm 设置为文本框
    self.textField.leftView = leftVw;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    /*********监听键盘弹出事件相关**************/
    // 1. 创建1个 NSNotificationCenter 对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 2. 监听键盘弹出通知
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

// ***************** 注意：监听通知以后一定要在监听通知的对象的dealloc方法中移除监听 **家卡水**水*来*杯水/.
- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - /***************** 监听键盘通知方法 **********************/
- (void)keyboardWillChangeFrame: (NSNotification *)noteInfo{
    NSLog(@"%@",noteInfo);
    // 1. 获取键盘的y值
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardY = rectEnd.origin.y;
    CGFloat tranformValue = keyBoardY - self.view.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue);
    }];
    
    
    // 让UITableView的最后一行滚动到最上面
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - /***************** dataSource 数据源方法 **********************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // 1 获取模型数据
    CZMessageFrame *modelFrame = self.messageFrames[indexPath.row];
    
    // 2 创建单元格
    CZMessageCell *cell = [CZMessageCell messageCellWithTableView:tableView];
    
    // 3 把模型设置个单元格对象
    cell.messageFrame = modelFrame;
    
    // 4 返回单元格
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.messageFrames.count;
}

// 返回每一行的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}


#pragma mark - /*****************Tableview 代理方法 **********************/
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 谁叫出的键盘，那么谁就是“第一响应者”，让“第一响应者”辞职，就可以把键盘叫回去
    [self.textField resignFirstResponder];
}

#pragma mark - /***************** 文本框代理方法 **********************/
// 当键盘上的return键被单击的时候触发
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // 1. 获取数据
    NSString *text = textField.text;
    
    // 发送一条用户信息
    [self sendMessage:text withType:CZMessageTypeMe];
    // 发送一条系统消息
    [self sendMessage:@"滚！！！😡" withType:CZMessageTypeOther];
    
    // 6. 清空textfieldneir
    textField.text = nil;
    return YES;
}

// 发送消息
- (void)sendMessage: (NSString *)msg withType: (CZMessageType)type{
    // 获取当前系统时间
    NSDate *nowData = [NSDate date];
    // 创建一个日期时间格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式
    formatter.dateFormat = @"今天 HH:mm";
    
    // 2. 创建模型和frame模型
    CZMessage *model = [CZMessage new];
    model.time = [formatter stringFromDate:nowData];
    model.text = msg;
    model.type = type;
    // 获取上一个模型
    CZMessage *lastMessage = (CZMessage *)[[self.messageFrames lastObject] message];
    //判断当前模型的“消息发送时间”是否和上一个模型的”消息发送时间”一致，如果一致做个标记
    if ([model.time isEqualToString: lastMessage.time]) {
        model.hideTime = YES;
    }
    
    
    CZMessageFrame *messageFrame = [CZMessageFrame new];
    messageFrame.message = model;
    // 3. 加入集合
    [self.messageFrames addObject:messageFrame];
    // 4. 刷新数据
    [self.tableView reloadData];
    // 5. 把最后一行滚到最上面
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
