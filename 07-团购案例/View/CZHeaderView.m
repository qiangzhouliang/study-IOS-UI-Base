//
//  CZHeaderView.m
//  07-团购案例
//
//  Created by swan on 2024/9/3.
//

#import "CZHeaderView.h"

@interface CZHeaderView () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBanner;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CZHeaderView

- (void)setImgs:(NSArray *)imgs{
    _imgs = imgs;
    self.scrollViewBanner.delegate = self;
    // 动态创建UIImageView添加到UIScrollView中
    CGFloat imgW = 373;
    CGFloat imgH = 160;
    CGFloat imgY = 0;
    for (int i = 0; i < self.imgs.count; i++) {
        // 创建一个UIImageView
        UIImageView *imgView = [[UIImageView alloc] init];
        // 设置图片
        imgView.image = [UIImage imageNamed:self.imgs[i]];
        
        // 计算每个UIImageView在UIScrollView中的x坐标
        CGFloat imgX = i * imgW;
        // 设置imageview的frame
        imgView.frame =  CGRectMake(imgX, imgY, imgW, imgH);
        // 把 imageview添加到 UIScrollView中
        [self.scrollViewBanner addSubview:imgView];
        
    }
    
    // 设置UIScrollView的内容的大小等于图片框中所显示的图片的实际大小
    CGFloat maxW = self.scrollViewBanner.frame.size.width * self.imgs.count;
    self.scrollViewBanner.contentSize = CGSizeMake(maxW, 0);
    
    // 实现UIScrollView的分页效果
    self.scrollViewBanner.pagingEnabled = YES;
    // 影藏滚动指示器
    self.scrollViewBanner.showsHorizontalScrollIndicator = NO;
    // 指定UIPageControl总页数
    self.pageControl.numberOfPages = self.imgs.count;
    // 设置默认当前第0页
    self.pageControl.currentPage = 0;
    // 添加滚动监听代理,让当前控制器作为UIScrollView的代码
    self.scrollViewBanner.delegate = self;
    
    // 创建一个"计时器"控件NSTimer控件
    // 通过scheduledTimerWithInterval这个方法创建的计时器控件，创建好以后自动启动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 修改 self.timer 的优先级与控件一样
    // 创建一个消息循环
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变 self.timer 对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/// 在这里就表示CZHeaderView已经从xib中创建好了
- (void)awakeFromNib{
    [super awakeFromNib];
    
}

#pragma mark - scrollView 滚动监听方法

// 自动滚动的方法
-(void)scrollImage {
    // 每次执行这个方法的时候，都要让图片滚动到下一页
    // 如何让UIScrolLView滚动到下一页？
    // 1. 获取当前的UIPageControl的页码
    NSInteger page = self.pageControl.currentPage;
    //2判断页码是否到了最后一页，如果到了最后一页，那么设置页码为Q（回到第一页）。如果没有到达最后一页，则让页码+1
    if (page == self.pageControl.numberOfPages - 1) {
        // 表示已经到达最后一页了
        page = 0;
    } else {
        page ++;
    }
    // 3. 用每页的宽度*（页码 +1）== 计算除了下一页的contentoffset.x
    CGFloat offsetX = page * self.scrollViewBanner.frame.size.width;
    // 4.设置UIScrollView的contentOffset等于新的偏移的值
//    [self.scrollViewBanner setContentOffset:CGPointMake(offsetX, 0)];
    [self.scrollViewBanner setContentOffset:CGPointMake(offsetX, 0) animated:true];
    // 如果图片现在已经滚动到最后一页了，那么就滚动到第一页
}

/// 即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"即将开始拖拽");
    // 听时定时器
    //调用invalidate一旦停止计时器，那么这个计时器就不可再重用了。下次必须重新创建一个新的计时器对象。
    [self.timer invalidate];
    //因为当调用完毕invalidate方法以后，这个计时器对象就已经废了，无法重用了。所以可以直接将self.timer设置为nil
    self.timer = nil;
}
/// 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"正在滚动, %f",scrollView.contentOffset.x);
    // 1.获取滚动的 x 方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    // 用已经偏移了得值，加上半页的宽度
    offsetX = offsetX + (scrollView.frame.size.width * 0.5);
    
    //2. 用x方向的偏移的值除以一张图片的宽度，取商就是当前滚动到了第几页（索引）
    int page = offsetX / scrollView.frame.size.width;
    
    // 3.将页码设置给UIPageControl
    self.pageControl.currentPage = page;
}
/// 结束拖拽完毕
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"拖拽完毕");
    // 重新启动计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    // 修改 self.timer 的优先级与控件一样
    // 创建一个消息循环
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变 self.timer 对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

+ (instancetype) headerView{
    CZHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"CZHeaderView" owner:nil options:nil].firstObject;
    return headerView;
}

@end
