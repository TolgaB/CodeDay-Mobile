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
    _communicate = [[AppCommunicate alloc] init];
    [self setUpUserValues];
}

-(void)setUpUserValues {
   userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    userInfo = [[NSDictionary alloc] init];
    userInfo = [_communicate getRegisterInfo:userID];
    nameLabel.text = [userInfo objectForKeyedSubscript:@"name"];
    emailLabel.text = [userInfo objectForKeyedSubscript:@"email"];
    NSLog(@"manual breakpoint");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
