#import "BCTabBar.h"
#import "BCTab.h"
#define kTabMargin 0.0

@interface BCTabBar ()
@property (nonatomic, retain) UIImage *backgroundImage;

- (void)positionArrowAnimated:(BOOL)animated;
@end

@implementation BCTabBar
@synthesize tabs, selectedTab, backgroundImage, arrow, delegate;

- (id)initWithFrame:(CGRect)aFrame {

	if (self = [super initWithFrame:aFrame]) {
        
//		self.backgroundImage = [UIImage imageNamed:@"top_bottom.png"];
        self.backgroundColor=[UIColor whiteColor];
//		self.arrow = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCTabBarController.bundle/tab-arrow.png"]] autorelease];
		if(self.arrow)
		{
		CGRect r = self.arrow.frame;
		r.origin.y = - (r.size.height - 2);
		self.arrow.frame = r;
		[self addSubview:self.arrow];
		}
		self.userInteractionEnabled = YES;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | 
		                        UIViewAutoresizingFlexibleTopMargin;
						 
	}
	
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
//	CGContextRef context = UIGraphicsGetCurrentContext();
	[self.backgroundImage drawInRect:rect];
//	[[UIColor blackColor] set];
//	CGContextFillRect(context, CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2));
}

- (void)setTabs:(NSArray *)array {
	for (BCTab *tab in tabs) {
		[tab removeFromSuperview];
	}
	
	[tabs release];
	tabs = [array retain];
	
	for (BCTab *tab in tabs) {
		tab.userInteractionEnabled = YES;
		[tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchDown];
	}
	[self setNeedsLayout];
}

- (void)setSelectedTab:(BCTab *)aTab animated:(BOOL)animated {
	if (aTab != selectedTab) {
		[selectedTab release];
		selectedTab = [aTab retain];
		selectedTab.selected = YES;
		
		for (BCTab *tab in tabs) {
			if (tab == aTab) continue;
			
			tab.selected = NO;
		}
	}
	
	[self positionArrowAnimated:animated];	
}

- (void)setSelectedTab:(BCTab *)aTab {
	if(self.arrow)
	{
	    [self setSelectedTab:aTab animated:YES];
	}
	else 
	{
		[self setSelectedTab:aTab animated:NO];
	}

}

- (void)tabSelected:(BCTab *)sender {
	[self.delegate tabBar:self didSelectTabAtIndex:[self.tabs indexOfObject:sender]];
}

- (void)positionArrowAnimated:(BOOL)animated {
	if (animated) 
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
	}
	
	if(self.arrow)
	{
	CGRect f = self.arrow.frame;
	f.origin.x = self.selectedTab.frame.origin.x + ((self.selectedTab.frame.size.width / 2) - (f.size.width / 2));
	self.arrow.frame = f;
	}
	
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect f = self.bounds;
	f.size.width /= self.tabs.count;
	f.size.width -= (kTabMargin * (self.tabs.count + 1)) / self.tabs.count;
	for (BCTab *tab in self.tabs) {
		f.origin.x += kTabMargin;
		tab.frame = f;
		f.origin.x += f.size.width;
		[self addSubview:tab];
	}
	
	[self positionArrowAnimated:NO];
}

- (void)dealloc {
	self.tabs = nil;
	self.selectedTab = nil;
	self.backgroundImage = nil;
	[super dealloc];
}


- (void)setFrame:(CGRect)aFrame {
	[super setFrame:aFrame];
	[self setNeedsDisplay];
}


@end
