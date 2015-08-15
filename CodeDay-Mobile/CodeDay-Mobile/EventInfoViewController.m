//
//  EventInfoViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/14/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "EventInfoViewController.h"
#import "AppCommunicate.h"
@interface EventInfoViewController ()
@property (nonatomic, strong)AppCommunicate *communicate;
@end
@implementation EventInfoViewController {
    NSDictionary *retrievedData;
    __weak IBOutlet UILabel *eventNameLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _communicate = [[AppCommunicate alloc] init];
    [self retrieveInfo];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)retrieveInfo {
    NSString *theID = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    retrievedData = [_communicate getEventInfo:theID];
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    [navBar setFrame:CGRectMake(0,0,screenWidth,(screenHeight/13))];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.title = [retrievedData objectForKeyedSubscript:@"name"];
    [navBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:navBar];
}

@end
