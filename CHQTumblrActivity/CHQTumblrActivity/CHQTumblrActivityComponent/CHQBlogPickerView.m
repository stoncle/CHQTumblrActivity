//
//  CHQBlogPickerView.m
//  ShareTest
//
//  Created by stoncle on 14-9-17.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import "CHQBlogPickerView.h"
@implementation CHQBlogPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *blogLabel = [[UILabel alloc]init];
        [blogLabel setText:NSLocalizedString(@"Blog", @"Blog")];
        [self addSubview:blogLabel];
        self.blogLabel = blogLabel;
        
        CHQBlogPickerButton *blogPickerButton = [[CHQBlogPickerButton alloc]init];
        [blogPickerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [blogPickerButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:15.0]];
        [self addSubview:blogPickerButton];
        self.blogPickerButton = blogPickerButton;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    frame.origin.x = 20;
    frame.size.width -= frame.origin.x;
    CGFloat labelWidth = [_blogLabel sizeThatFits:CGSizeZero].width;
    CGRect frame1, frame2;
    CGRectDivide(frame, &frame1, &frame2, labelWidth, CGRectMinXEdge);
    [_blogLabel setFrame:frame1];
    CGRect frame3, frame4;
    CGRectDivide(frame2, &frame3, &frame4, 10, CGRectMinXEdge);
    [_blogPickerButton setFrame:frame4];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
