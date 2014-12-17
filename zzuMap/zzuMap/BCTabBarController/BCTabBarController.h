#import "BCTabBar.h"

@class BCTabBarView;

@interface BCTabBarController : UIViewController <BCTabBarDelegate> {
	NSArray *viewControllers;
	UIViewController *selectedViewController;
	BCTabBar *tabBar;
	BCTabBarView *tabBarView;
	BOOL visible;
    NSInteger selectindex;
}
@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) BCTabBar *tabBar;
@property (nonatomic, retain) UIViewController *selectedViewController;
@property (nonatomic, retain) BCTabBarView *tabBarView;
@property (nonatomic) NSUInteger selectedIndex;

- (void)setTabBarHidden:(BOOL)hide animated:(BOOL)animate;
- (void)setBadgeNumber:(NSUInteger)number withIndex:(NSUInteger)index;
@end
