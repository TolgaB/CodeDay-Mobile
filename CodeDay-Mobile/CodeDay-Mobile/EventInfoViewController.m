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
    NSLog(@"manual");
}

@end
