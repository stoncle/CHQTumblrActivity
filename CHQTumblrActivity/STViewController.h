//
//  STViewController.h
//  ShareTest
//
//  Created by Pinssible on 14-9-4.
//  Copyright (c) 2014年 Pinssible. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "STPocketActivity.h"
#import "CHQTumblrActivity.h"
#import "TMAPIClient.h"
@interface STViewController : UIViewController <CHQTumblrActivityDelegate>
@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) UIViewController *con;
@end
