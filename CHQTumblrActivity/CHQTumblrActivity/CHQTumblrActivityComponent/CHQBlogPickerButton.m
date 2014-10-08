//
//  CHQBlogPickerButton.m
//  ShareTest
//
//  Created by stoncle on 14-9-17.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import "CHQBlogPickerButton.h"

#define kTextImageSpace         10.0
#define kRightPadding           30.0
#define kDisclosureRightMargin  15.0

@interface CHQBlogPickerButton ()

@property (nonatomic, strong) UIImageView *disclosureIndicator;

@end

@implementation CHQBlogPickerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        UIImage *disclosureImage;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            disclosureImage = [[UIImage imageNamed:@"ENSDKResources.bundle/ENNextIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        else
        {
            disclosureImage = [UIImage imageNamed:@"ENSDKResources.bundle/ENNextIcon"];
        }
        
        self.disclosureIndicator = [[UIImageView alloc]initWithImage:disclosureImage];
        self.disclosureIndicator.center = CGPointMake(CGRectGetMaxX(self.bounds) - kDisclosureRightMargin, CGRectGetMidY(self.bounds));
        [self.disclosureIndicator setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin |
         UIViewAutoresizingFlexibleLeftMargin |
         UIViewAutoresizingFlexibleBottomMargin |
         UIViewAutoresizingFlexibleTopMargin];
        [self addSubview:self.disclosureIndicator];
    }
    return self;
}

- (void)setShouldHideDisclosureIndicator:(BOOL)shouldHideDisclosureIndicator
{
    _shouldHideDisclosureIndicator = shouldHideDisclosureIndicator;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.disclosureIndicator setHidden:_shouldHideDisclosureIndicator];
    if(_shouldHideDisclosureIndicator)
    {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, kDisclosureRightMargin)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, kDisclosureRightMargin)];
    } else {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 2 * kDisclosureRightMargin)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 2 * kDisclosureRightMargin)];
    }
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
