//
//  STViewController.m
//  ShareTest
//
//  Created by Pinssible on 14-9-4.
//  Copyright (c) 2014年 Pinssible. All rights reserved.
//

#import "STViewController.h"

@interface STViewController ()
{
    
}

@end

@implementation STViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tapped:(id)sender {
    CHQTumblrActivity *tumblrActivity = [[CHQTumblrActivity alloc]init];
    tumblrActivity.delegate = self;
    NSString *item = @"hahah";
    UIImage *image = [UIImage imageNamed:@"snow.jpg"];
    NSArray *items = [NSArray arrayWithObjects:(item), (image), nil];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                                      applicationActivities:@[tumblrActivity]];
    
    tumblrActivity.con = self;
    activityController.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIPopoverPresentationController *popover = activityController.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = sender;
            //        popover.sourceRect = sender.view.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
