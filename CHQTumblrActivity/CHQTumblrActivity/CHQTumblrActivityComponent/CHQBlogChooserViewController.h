//
//  STBlogChooserViewController.h
//  ShareTest
//
//  Created by stoncle on 14-9-17.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHQBlogChooserViewController;
@protocol CHQBlogChooserViewControllerDelegate <NSObject>

- (void)blogChooser:(CHQBlogChooserViewController *)chooser didChooseBlog:(NSString *)blog;

@end

@interface CHQBlogChooserViewController : UITableViewController
@property (nonatomic, weak) id<CHQBlogChooserViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *blogList;
@property (nonatomic, strong) NSString *currentBlog;

@end
