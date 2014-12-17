//
//  BadgeView.h
//  letao
//
//  Created by caiting on 11-7-26.
//  Copyright 2011 yek. All rights reserved.
//

#import "BadgeView.h"
@implementation BadgeView
@synthesize badgeValue;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		nums=[[NSMutableArray array]retain];
		
		//UIImage *image =[YK_MyImage getUIImage:@"number_bg.png"];
		UIImage *image =[UIImage imageNamed:@"number_bg.png"];
		//bg_img = [image stretchableImageWithLeftCapWidth:16 topCapHeight:0];
		bg_img = [image stretchableImageWithLeftCapWidth:12 topCapHeight:0];
		
		iv_bg=[[UIImageView alloc]initWithImage:bg_img];
		
		for(int i=0;i<10;i++)
		{
			NSString *filePath = [[NSString alloc] initWithFormat:@"num%d.png",i];
			[nums addObject:[UIImage imageNamed:filePath]];
			[filePath release];
		}
		[self setUserInteractionEnabled: NO];
		self.backgroundColor=[UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	if (badgeValue == 0)
		return;
	if(badgeValue>=1000)
	{
		[bg_img drawInRect:CGRectMake(0, 0, 49, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue/1000] drawAtPoint:CGPointMake(9,5)];
		[(UIImage *)[nums objectAtIndex:(badgeValue-(badgeValue/1000)*1000)/100] drawAtPoint:CGPointMake(16,5)];
		[(UIImage *)[nums objectAtIndex:(badgeValue-(badgeValue/100)*100)/10] drawAtPoint:CGPointMake(23,5)];
		[(UIImage *)[nums objectAtIndex:badgeValue-(badgeValue/10)*10] drawAtPoint:CGPointMake(30,5)];
	}
	else if(badgeValue>=100)
	{
		
		[bg_img drawInRect:CGRectMake(0, 0, 41, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue/100] drawAtPoint:CGPointMake(9,5)];
		[(UIImage *)[nums objectAtIndex:(badgeValue-(badgeValue/100)*100)/10] drawAtPoint:CGPointMake(16,5)];
		[(UIImage *)[nums objectAtIndex:badgeValue-(badgeValue/10)*10] drawAtPoint:CGPointMake(23,5)];
	}
	else if(badgeValue>=10)
	{
		[bg_img drawInRect:CGRectMake(0, 0, 32, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue/10] drawAtPoint:CGPointMake(9,5)];
		[(UIImage *)[nums objectAtIndex:badgeValue-(badgeValue/10)*10] drawAtPoint:CGPointMake(16,5)];
	}
	else if(badgeValue>0)
	{
		//		[bg_img drawAtPoint:CGPointMake(0,0)];
		[bg_img drawInRect:CGRectMake(5, 0, 24, 24)];
		[(UIImage *)[nums objectAtIndex:badgeValue] drawAtPoint:CGPointMake(14,5)];
	}
	
	
	
}

-(void)setBadge:(NSInteger)_badgeValue
{
	badgeValue=_badgeValue;
	[self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesBegan:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.nextResponder touchesMoved:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.nextResponder touchesEnded:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.nextResponder touchesCancelled:touches withEvent:event];
	[super touchesBegan:touches withEvent:event];
}
- (void)dealloc {
	for (UIView *view in [self subviews]) {
		[view removeFromSuperview];
	}
	[self removeFromSuperview];
	[nums release];
    [super dealloc];
}


@end


@implementation UIView (addbadge)

-(BadgeView*) badgeView{
	BadgeView* ret=(BadgeView*)[self viewWithTag:YK_TAG_BADGE_VIEW_SUBVIEW];
	if(ret==nil){
		float selfWidth=self.frame.size.width;
		float badgeWidth=50;
		float badgeHeight=33;
		CGRect badgeFrame=CGRectMake(selfWidth-badgeWidth, 0 , badgeWidth, badgeHeight);
		ret=[[BadgeView alloc] initWithFrame:badgeFrame];
		ret.tag=YK_TAG_BADGE_VIEW_SUBVIEW;
		[self addSubview:ret];
		[ret release];
	}
	assert([ret isKindOfClass:[BadgeView class]]);
	
	return ret;
}
-(void) setBadgeNum:(NSInteger)anum{
	BadgeView* badgeView=[self badgeView];
	assert(badgeView!=nil);
	[badgeView setBadge:anum];
	badgeView.hidden=(anum==0);
}
-(NSInteger) badgeNum{
	BadgeView* badgeView=[self badgeView];
	assert(badgeView!=nil);
	return [badgeView badgeValue];
}

@end

