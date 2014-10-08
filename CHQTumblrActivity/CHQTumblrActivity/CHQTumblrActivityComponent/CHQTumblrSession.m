//
//  CHQTumblrSession.m
//  ShareTest
//
//  Created by stoncle on 14-9-13.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import "CHQTumblrSession.h"

@implementation CHQTumblrSession
+ (CHQTumblrSession *)sharedSession
{
    static CHQTumblrSession * session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[CHQTumblrSession alloc] init];
    });
    return session;
}

- (void)saveToken:(NSString *)token TokenSecret:(NSString *)tokenSecret
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDate *tokenTime = [NSDate date];
    [userDef setObject:token forKey:@"TumblrToken"];
    [userDef setObject:tokenTime forKey:@"TokenTime"];
    [userDef setObject:tokenSecret forKey:@"TumblrTokenSecret"];
    [userDef synchronize];
}
- (NSString *)currentToken
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"TumblrToken"];
    return token;
}
- (NSString *)currentTokenSecret
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"TumblrTokenSecret"];
    return token;
}
- (NSDate *)currentTokenTime
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDate *currentTokenTime = [userDef objectForKey:@"TokenTime"];
    return currentTokenTime;
}
- (void)setToken
{
    [TMAPIClient sharedInstance].OAuthToken = [self currentToken];
    [TMAPIClient sharedInstance].OAuthTokenSecret = [self currentTokenSecret];
}
- (BOOL)ifCurrentTokenExpired
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDate *tokenDate = [userDef objectForKey:@"TokenTime"];
    //a year
    if([tokenDate timeIntervalSinceNow] > 31622400)
    {
        return YES;
    }
    return NO;
}
- (BOOL)ifIsAuthenticated
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDate *tokenDate = [userDef objectForKey:@"TokenTime"];
    if(tokenDate != nil && ![self ifCurrentTokenExpired])
    {
        return YES;
    }
    return NO;
}
@end
