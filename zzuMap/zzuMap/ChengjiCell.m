//
//  ChengjiCell.m
//  zzuMap
//
//  Created by 李鹏飞 on 14/10/23.
//  Copyright (c) 2014年 zzu. All rights reserved.
//

#import "ChengjiCell.h"

@implementation ChengjiCell
@synthesize kechengLable,jidianLabel,chengjiLabel;
- (void)awakeFromNib
{
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        kechengLable = [[UILabel alloc]init];
        [kechengLable setBackgroundColor:[UIColor clearColor]];
        [kechengLable setFrame:CGRectMake(20,5, 200, 25)];
        [kechengLable setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:kechengLable];
        
        chengjiLabel=[[UILabel alloc]init];
        [chengjiLabel setFont:[UIFont systemFontOfSize:14]];
        [chengjiLabel setFrame:CGRectMake(215,5,40, 25)];
        chengjiLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:chengjiLabel];

        jidianLabel=[[UILabel alloc]init];
        [jidianLabel setFont:[UIFont systemFontOfSize:14]];
        [jidianLabel setFrame:CGRectMake(260,5, 40, 25)];
        jidianLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:jidianLabel];
        
    }
    return  self;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
