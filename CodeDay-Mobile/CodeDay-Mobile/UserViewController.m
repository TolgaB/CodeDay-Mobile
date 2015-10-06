//
//  UserViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/17/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "UserViewController.h"
#import "AppCommunicate.h"

@interface UserViewController ()
@property (nonatomic, strong)AppCommunicate *communicate;
@end

@implementation UserViewController {
    
    __weak IBOutlet UILabel *nameLabel;
    NSString *userID;
    __weak IBOutlet UILabel *emailLabel;
    NSDictionary *userInfo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUserValues];
    _communicate = [[AppCommunicate alloc] init];
}

-(void)setUpUserValues {
   userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    userInfo = [_communicate getRegisterInfo:userID];
    NSLog(@"manual breakpoint");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
