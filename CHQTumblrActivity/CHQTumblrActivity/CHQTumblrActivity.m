//
//  CHQTumblrActivity.m
//  ShareTest
//
//  Created by stoncle on 14-9-12.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import "CHQTumblrActivity.h"
@interface CHQTumblrActivity()
{
    UINavigationController * nav;
}
@end
@implementation CHQTumblrActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle
{
    return NSLocalizedString(@"Save to Tumblr", @"Save to Tumblr");
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"UIActivityTumblr"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    // A prepared ENNote is allowed if it's the only item given.
    if (activityItems.count == 1 && [activityItems[0] isKindOfClass:[UIImage class]]) {
        return YES;
    }
    
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSString class]] ||
            [item isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    [[CHQTumblrSession sharedSession] setToken];
    for(id item in activityItems)
    {
        if([item isKindOfClass:[NSString class]])
        {
            self.sharedCaption = item;
        }
        else if([item isKindOfClass:[UIImage class]])
        {
            self.sharedImage = item;
        }
    }
}

-(void)performActivity
{
    if(![[CHQTumblrSession sharedSession] ifIsAuthenticated])
    {
//        [[TMAPIClient sharedInstance] authenticate:kAuthenticate WithViewController:self.con callback:^(NSError *error) {
//            // You are now authenticated (if !error)
//            if(error)
//            {
//                NSLog(@"%@", error);
//                return;
//            }
//            else
//            {
//                [[CHQTumblrSession sharedSession] saveToken:[TMAPIClient sharedInstance].OAuthToken TokenSecret:[TMAPIClient sharedInstance].OAuthTokenSecret];
//                NSLog(@"assess good");
//                NSLog(@"%@", [TMAPIClient sharedInstance].OAuthToken);
//                NSLog(@"%@", [TMAPIClient sharedInstance].OAuthTokenSecret);
//                [self presentShareController];
//            }
//        }];
        [[TMAPIClient sharedInstance] authenticate:kAuthenticate callback:^(NSError *error) {
            // You are now authenticated (if !error)
            if(error)
            {
                NSLog(@"%@", error);
                return;
            }
            else
            {
                [[CHQTumblrSession sharedSession] saveToken:[TMAPIClient sharedInstance].OAuthToken TokenSecret:[TMAPIClient sharedInstance].OAuthTokenSecret];
                NSLog(@"assess good");
                NSLog(@"%@", [TMAPIClient sharedInstance].OAuthToken);
                NSLog(@"%@", [TMAPIClient sharedInstance].OAuthTokenSecret);
                [self presentShareController];
            }
        }];
    }
    else
    {
        [self presentShareController];
    }
}
- (void)presentShareController
{
    CHQShareToTumblrViewController *s2t = [[CHQShareToTumblrViewController alloc]init];
    s2t.delegate = self;
    nav = [[UINavigationController alloc] initWithRootViewController:s2t];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.con presentViewController:nav animated:YES completion:nil];
}
#pragma mark - STShareToTumblrViewControllerDelegate
- (NSString *)sharedCaption
{
    return _sharedCaption;
}
- (UIImage *)sharedImage
{
    return _sharedImage;
}
- (void)viewController:(CHQShareToTumblrViewController *)viewController didFinishWithSuccess:(BOOL)success uploadError:(NSError *)error
{
    if(success)
    {
        [nav dismissViewControllerAnimated:YES completion:nil];
        [self activityDidFinish:success];
    }
    if ([_delegate respondsToSelector:@selector(activity:didFinishWithSuccess:error:)]) {
        [_delegate activity:self didFinishWithSuccess:success error:error];
    }
}

@end
