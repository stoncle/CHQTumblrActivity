//
//  STAppDelegate.m
//  ShareTest
//
//  Created by Pinssible on 14-9-4.
//  Copyright (c) 2014年 Pinssible. All rights reserved.
//

#import "STAppDelegate.h"
#import "TMAPIClient.h"

@implementation STAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    // Override point for customization after application launch.
//    [[PocketAPI sharedAPI] setConsumerKey:@"31810-b884d5081246d20420ad04ea"];
//    
//	[[PocketAPI sharedAPI] setURLScheme:@"pocketapp31810"];
    
    
    [TMAPIClient sharedInstance].OAuthConsumerKey = @"";
    [TMAPIClient sharedInstance].OAuthConsumerSecret = @"";
    
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL tumblrHandle = [[TMAPIClient sharedInstance] handleOpenURL:url];
    // ...
    return tumblrHandle;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        [[EvernoteSession sharedSession] handleDidBecomeActive];
//    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end