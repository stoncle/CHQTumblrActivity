//
//  CHQShareToTumblrViewController.m
//  ShareTest
//
//  Created by stoncle on 14-9-12.
//  Copyright (c) 2014年 stoncle. All rights reserved.
//

#import "CHQShareToTumblrViewController.h"
@interface CHQShareToTumblrViewController ()

@property (nonatomic, strong) UILabel *captionLabel;
@property (nonatomic, strong) UITextField *captionTextField;
@property (nonatomic, strong) UIImageView *sharedImageView;
@property (nonatomic, strong) CHQBlogPickerButton *blogPickerButton;
@property (nonatomic, strong) CHQBlogPickerView *blogPickerView;
@property (nonatomic, strong) RMSTokenView *tagsView;
@property (nonatomic, strong) NSMutableArray *blogList;
@property (nonatomic, strong) NSString *currentBlog;

@end
@implementation CHQShareToTumblrViewController

- (void)loadView {
    [super loadView];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    UILabel *captionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//    captionLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:captionLabel];
//    self.captionLabel = captionLabel;
    
    
//    UIView *divider1 = [[UIView alloc] initWithFrame:CGRectZero];
//    divider1.translatesAutoresizingMaskIntoConstraints = NO;
//    [divider1 setBackgroundColor: [UIColor grayColor]];
//    [self.view addSubview:divider1];
    
    
    UITextField *captionTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    captionTextField.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kTextLeftPadding, 0)];
    captionTextField.leftView = paddingView1;
    captionTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:captionTextField];
    self.captionTextField = captionTextField;
    
    UIView *divider1 = [[UIView alloc] initWithFrame:CGRectZero];
    divider1.translatesAutoresizingMaskIntoConstraints = NO;
    [divider1 setBackgroundColor: [UIColor grayColor]];
    [self.view addSubview:divider1];
    
    RMSTokenView *tagsView = [[RMSTokenView alloc]initWithFrame:CGRectZero];
    tagsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tagsView];
    self.tagsView = tagsView;
    UIView *divider3 = [[UIView alloc] initWithFrame:CGRectZero];
    divider3.translatesAutoresizingMaskIntoConstraints = NO;
    [divider3 setBackgroundColor: [UIColor grayColor]];
    [self.view addSubview:divider3];
    CHQBlogPickerView *blogPickView = [[CHQBlogPickerView alloc]initWithFrame:CGRectZero];
    blogPickView.translatesAutoresizingMaskIntoConstraints = NO;
    [blogPickView addTarget:self action:@selector(showBlogChooser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blogPickView];
    self.blogPickerView = blogPickView;
    self.blogPickerButton = blogPickView.blogPickerButton;
    [self.blogPickerButton addTarget:self action:@selector(showBlogChooser) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *divider2 = [[UIView alloc] initWithFrame:CGRectZero];
    divider2.translatesAutoresizingMaskIntoConstraints = NO;
    [divider2 setBackgroundColor: [UIColor grayColor]];
    [self.view addSubview:divider2];
    
    UIImageView *sharedImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    sharedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:sharedImageView];
    self.sharedImageView = sharedImageView;
    
    NSString *format = [NSString stringWithFormat:@"V:|[captionTextField(%f)][divider1(%f)][tagsView(>=%f)][divider3(%f)][blogPickView(%f)][divider2(%f)][sharedImageView]|", kCaptionTextFieldHeight, OnePixHeight(), kTagsViewHeight, OnePixHeight(), kBlogPickerViewHeight, OnePixHeight()];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(captionTextField, divider1, tagsView, divider3, blogPickView, divider2, sharedImageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[captionTextField]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(captionTextField)]];
    self.navigationItem.title = kSaveToTumblr;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.tagsView.placeholder = NSLocalizedString(@"Add Tag", @"Add Tag");
    NSLog(@"%f,%f", self.blogPickerView.blogLabel.bounds.size.width, self.blogPickerView.blogPickerButton.bounds.size.width);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[STTumblrSession sharedSession] setToken];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [[TMAPIClient sharedInstance] userInfo:^(id result, NSError *error) {
        if(error)
        {
            NSLog(@"%@", error);
            if([error code] == 401)
            {
                self.navigationItem.rightBarButtonItem.enabled = NO;
//                [[TMAPIClient sharedInstance] authenticate:kAuthenticate WithViewController:self callback:^(NSError *error) {
//                    // You are now authenticated (if !error)
//                    if(error)
//                    {
//                        NSLog(@"%@", error);
//                    }
//                    else
//                    {
//                        [[STTumblrSession sharedSession] saveToken:[TMAPIClient sharedInstance].OAuthToken TokenSecret:[TMAPIClient sharedInstance].OAuthTokenSecret];
//                        NSLog(@"assess good");
//                        NSLog(@"%@", [TMAPIClient sharedInstance].OAuthToken);
//                        NSLog(@"%@", [TMAPIClient sharedInstance].OAuthTokenSecret);
//                        self.navigationItem.rightBarButtonItem.enabled = YES;
//                    }
//                }];
                [[TMAPIClient sharedInstance] authenticate:kAuthenticate callback:^(NSError *error) {
                    // You are now authenticated (if !error)
                    if(error)
                    {
                        NSLog(@"%@", error);
                    }
                    else
                    {
                        [[CHQTumblrSession sharedSession] saveToken:[TMAPIClient sharedInstance].OAuthToken TokenSecret:[TMAPIClient sharedInstance].OAuthTokenSecret];
                        NSLog(@"assess good");
                        NSLog(@"%@", [TMAPIClient sharedInstance].OAuthToken);
                        NSLog(@"%@", [TMAPIClient sharedInstance].OAuthTokenSecret);
                        self.navigationItem.rightBarButtonItem.enabled = YES;
                    }
                }];
            }
        }
        if (!error)
        {
            NSLog(@"Got some user info");
            NSLog(@"%@", result);
            NSDictionary *userData = result;
            NSDictionary *user = [userData objectForKey:@"user"];
            NSArray *blogs = [user objectForKey:@"blogs"];
            int i = 0;
            if(!_blogList)
            {
                _blogList = [[NSMutableArray alloc]init];
            }
            for(; i<blogs.count; i++)
            {
                NSDictionary *blog = blogs[i];
                NSString *blogName = [blog objectForKey:@"name"];
                NSString *finalBlogName = [NSString stringWithFormat:@"%@.tumblr.com", blogName];
                [_blogList addObject:finalBlogName];
            }
            _currentBlog = [_blogList objectAtIndex:0];
            [self updateCurrentBlogDisplay];
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        
    }];
    self.captionLabel.text = kCaptionLabel;
    self.captionTextField.text = [self.delegate sharedCaption];
    if(self.captionTextField.text.length == 0)
    {
        [self.captionTextField setPlaceholder:kCaptionTextFieldPlaceHolder];
    }
    self.sharedImageView.image = [self.delegate sharedImage];
}
- (NSString *)stringFromTags:(NSArray *)tags
{
    NSLog(@"%@", [tags componentsJoinedByString:@","]);
    return [tags componentsJoinedByString:@","];
}

#pragma mark - Actions

- (void)save:(id)sender
{
//    [[STTumblrSession sharedSession] setToken];
    [[TMAPIClient sharedInstance] post:_currentBlog type:@"photo" parameters:@{@"tags" : [self stringFromTags:[self.tagsView tokens]], @"caption" : [self.delegate sharedCaption], @"source" : @"http://www.baidu.com/img/bdlogo.png"} callback:^(id response, NSError *error) {
        if(error)
        {
            NSLog(@"%@", error);
        }
        else
        {
            NSLog(@"%@", response);
            NSLog(@"good");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
//    [[TMAPIClient sharedInstance] photo:_currentBlog
//                          filePathArray:@[[[NSBundle mainBundle] pathForResource:@"snow" ofType:@"jpg"]]
//                       contentTypeArray:nil
//                          fileNameArray:@[@"photoFromPadgram"]
//                             parameters:@{@"caption" : [self.delegate sharedCaption], @"tags" : [self stringFromTags:[self.tagsView tokens]]}
//                               callback:^(id response, NSError *error) {
//                                   if (error)
//                                   {
//                                       NSLog(@"%@", error);
//                                       if([error code] == 401)
//                                       {
//                                           self.navigationItem.rightBarButtonItem.enabled = NO;
//                                           [[TMAPIClient sharedInstance] authenticate:kAuthenticate WithViewController:self callback:^(NSError *error) {
//                                               // You are now authenticated (if !error)
//                                               if(error)
//                                               {
//                                                   NSLog(@"%@", error);
//                                               }
//                                               else
//                                               {
//                                                   [[STTumblrSession sharedSession] saveToken:[TMAPIClient sharedInstance].OAuthToken TokenSecret:[TMAPIClient sharedInstance].OAuthTokenSecret];
//                                                   NSLog(@"assess good");
//                                                   NSLog(@"%@", [TMAPIClient sharedInstance].OAuthToken);
//                                                   NSLog(@"%@", [TMAPIClient sharedInstance].OAuthTokenSecret);
//                                                   self.navigationItem.rightBarButtonItem.enabled = YES;
//                                               }
//                                           }];
//                                       }
//                                   }
//                                   else
//                                   {
//                                       NSLog(@"Posted to Tumblr");
//                                       [self dismissViewControllerAnimated:YES completion:nil];
//                                   }
//                               }];
}

- (void)showBlogChooser
{
    CHQBlogChooserViewController * chooser = [[CHQBlogChooserViewController alloc] init];
    chooser.delegate = self;
    chooser.blogList = self.blogList;
    [self.navigationController pushViewController:chooser animated:YES];
}



- (void)cancel:(id)sender
{
    NSLog(@"share cancelled");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate viewController:self didFinishWithSuccess:NO uploadError:[NSError errorWithDomain:@"tumblrDomain" code:0 userInfo:nil]];
}

- (void)updateCurrentBlogDisplay
{
    NSString *displayName = self.currentBlog;
    [self.blogPickerButton setTitle:displayName forState:UIControlStateNormal];
    if ([self.blogList count] == 1) {
        self.blogPickerButton.shouldHideDisclosureIndicator = YES;
        [self.blogPickerButton setEnabled:NO];
        [self.blogPickerView setEnabled:NO];
    } else {
        self.blogPickerButton.shouldHideDisclosureIndicator = NO;
        [self.blogPickerButton setEnabled:YES];
        [self.blogPickerView setEnabled:YES];
    }
}

#pragma mark - CHQBlogChooserViewControllerDelegate
-(void)blogChooser:(CHQBlogChooserViewController *)chooser didChooseBlog:(NSString *)blog
{
    self.currentBlog = blog;
    [self updateCurrentBlogDisplay];
    [self.navigationController popViewControllerAnimated:YES];
}
                                              
CGFloat OnePixHeight() {
    return 1.0/[UIScreen mainScreen].scale;
}

@end
