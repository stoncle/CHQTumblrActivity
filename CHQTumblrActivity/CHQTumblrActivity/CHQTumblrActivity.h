//
//  CHQTumblrActivity.h
//  ShareTest
//
//  Created by stoncle on 14-9-12.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHQShareToTumblrViewController.h"
@class CHQTumblrActivity;
@protocol CHQTumblrActivityDelegate <NSObject>
/**
 *  Delegate function to notify the user whether sharing to Evernote succeeded, called from the main thread
 *
 *  @param activity the Save to Evernote UIActivity
 *  @param success  whether the activity succeeded
 *  @param error    error if any
 */
- (void)activity:(CHQTumblrActivity *)activity didFinishWithSuccess:(BOOL)success error:(NSError *)error;
@end
@interface CHQTumblrActivity : UIActivity <CHQShareToTumblrViewControllerDelegate>
@property (nonatomic, strong) NSString *sharedCaption;
@property (nonatomic, strong) UIImage *sharedImage;
@property (nonatomic, weak) id<CHQTumblrActivityDelegate> delegate;
@property (nonatomic, strong) UIViewController *con;
@end
