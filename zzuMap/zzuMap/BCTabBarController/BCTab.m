#import "BCTab.h"
#import "Macro.h"

@interface BCTab ()
@property (nonatomic, retain) UIImage *rightBorder;
@property (nonatomic, retain) UIImage *background;
@end

@implementation BCTab
@synthesize rightBorder, background;

- (id)initWithIconImageName:(NSString *)imageName labelName:(NSString *)label1{
    if (self = [super init]) {
        self.adjustsImageWhenHighlighted = NO;
        
        self.backgroundColor = [UIColor clearColor];
        if(imageName)
        {
            NSString *selectedName=[imageName stringByReplacingOccurrencesOfString:@"normal" withString:@"pressed"];
            
//            NSString *selectedName = [NSString stringWithFormat:@"%@_pressed.%@",
//                                      [imageName stringByDeletingPathExtension],
//                                      [imageName pathExtension]];
            
            
            [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
            
            UILabel *label = [[UILabel alloc]init];
            label.text=label1;
            label.textAlignment=NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:9];
            label.frame=CGRectMake(self.bounds.origin.x+17, self.bounds.origin.y+32, 30, 20);
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.alpha=0.8;
            [self addSubview:label];
            [label release];
        }
        
    }
    return self;
}

- (void)dealloc {
	self.rightBorder = nil;
	self.background = nil;
	[super dealloc];
}

- (void)setHighlighted:(BOOL)aBool {
	
}

- (void)drawRect:(CGRect)rect {
	if (self.selected) {
		[background drawAtPoint:CGPointMake(-8, 0)];
		[rightBorder drawAtPoint:CGPointMake(self.bounds.size.width - rightBorder.size.width, 2)];
		//NSString *ns_subHome = @"首页";
		//[ns_subHome drawInRect:CGRectMake(0, 70, 70, 10) withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
//		CGContextRef c = UIGraphicsGetCurrentContext();
//		[RGBCOLOR(24, 24, 24) set]; 
//		CGContextFillRect(c, CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2));
//		[RGBCOLOR(14, 14, 14) set];		
//		CGContextFillRect(c, CGRectMake(0, self.bounds.size.height / 2, 0.5, self.bounds.size.height / 2));
//		CGContextFillRect(c, CGRectMake(self.bounds.size.width - 0.5, self.bounds.size.height / 2, 0.5, self.bounds.size.height / 2));
	}
}

- (void)setFrame:(CGRect)aFrame {
	[super setFrame:aFrame];
	[self setNeedsDisplay];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	UIEdgeInsets imageInsets = UIEdgeInsetsMake(floor((self.bounds.size.height / 2) -
												(self.imageView.image.size.height / 2)),
												floor((self.bounds.size.width / 2) -
												(self.imageView.image.size.width / 2)),
												floor((self.bounds.size.height / 2) -
												(self.imageView.image.size.height / 2)),
												floor((self.bounds.size.width / 2) -
												(self.imageView.image.size.width / 2)));
	self.imageEdgeInsets = imageInsets;
}

@end
