
// 1.判断是否为iPhone5的宏
#define iPhone5 ([UIScreen mainScreen].bounds.size.height >=568)

// 2.友盟KEY
#define UMENG_APPKEY @"5449f258fd98c550a601e4e2"

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

// 3.设置cell的边框宽度
#define kCellBorderWidth 10
// 设置tableView的边框宽度
#define kTableBorderWidth 8
// 设置每个cell之间的间距
#define kCellMargin 8
// 设置微博dock的高度
#define kStatusDockHeight 30
// 设置转发微博dock的高度
#define kRetweetedDockHeight 35

// 4.cell内部子控件的字体设置
#define kScreenNameFont [UIFont systemFontOfSize:13]
#define kTimeFont [UIFont systemFontOfSize:11]
#define kSourceFont kTimeFont
#define kTextFont [UIFont systemFontOfSize:13]
#define kRetweetedTextFont [UIFont systemFontOfSize:13]
#define kRetweetedScreenNameFont [UIFont systemFontOfSize:13]

// 5.获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// 全局的背景色
#define kGlobalBg kColor(230, 230, 230)

// 6.cell内部子控件的颜色设置
// 会员昵称颜色
#define kMBScreenNameColor kColor(243, 101, 18)
// 非会员昵称颜色
#define kScreenNameColor kColor(93, 93, 93);
// 被转发微博昵称颜色
#define kRetweetedScreenNameColor kColor(63, 104, 161)

// 7.图片
// 会员皇冠图标
#define kMBIconW 14
#define kMBIconH 14

// 头像
#define kIconSmallW 34
#define kIconSmallH 34

#define kIconDefaultW 50
#define kIconDefaultH 50

#define kIconBigW 85
#define kIconBigH 85

// 认证加V图标
#define kVertifyW 18
#define kVertifyH 18

// 8.取出滚动条
#pragma mark 重写这个方法的目的。去掉父类默认的操作：显示滚动条
#define kHideScroll - (void)viewDidAppear:(BOOL)animated { }