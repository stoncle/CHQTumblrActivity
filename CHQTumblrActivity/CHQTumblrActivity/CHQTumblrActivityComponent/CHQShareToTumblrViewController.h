//
//  CHQShareToTumblrViewController.h
//  ShareTest
//
//  Created by stoncle on 14-9-12.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHQTumblrSession.h"
#import "CHQBlogPickerView.h"
#import "CHQBlogPickerButton.h"
#import "RMSTokenView.h"
#import "CHQBlogChooserViewController.h"

#define kCaptionLabelHeight 50.0
#define kCaptionTextFieldHeight 50.0
#define kSaveToTumblr @"save to tumblr"
#define kCaptionLabel @"Caption"
#define kCaptionTextFieldPlaceHolder @"Add Caption"
#define kTextLeftPadding 30
#define kTitleViewHeight        50.0
#define kTagsViewHeight         44.0
#define kBlogPickerViewHeight     50.0

@class CHQShareToTumblrViewController;
@protocol CHQShareToTumblrViewControllerDelegate <NSObject>
- (NSString *)sharedCaption;
- (UIImage *)sharedImage;
- (void)viewController:(CHQShareToTumblrViewController *)viewController didFinishWithSuccess:(BOOL)success uploadError:(NSError *)error;
@end
@interface CHQShareToTumblrViewController : UIViewController <CHQBlogChooserViewControllerDelegate>
@property (nonatomic, weak) id<CHQShareToTumblrViewControllerDelegate> delegate;
@end
