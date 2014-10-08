//
//  CHQTumblrSession.h
//  ShareTest
//
//  Created by stoncle on 14-9-13.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMAPIClient.h"
#define kAuthenticate @"mytest"

@interface CHQTumblrSession : NSObject
@property BOOL isAuthenticated;
+ (CHQTumblrSession *)sharedSession;
- (void)saveToken:(NSString *)token TokenSecret:(NSString *)tokenSecret;
- (NSString *)currentToken;
- (void)setToken;
- (BOOL)ifIsAuthenticated;
- (BOOL)ifCurrentTokenExpired;
@end
