//
//  MyAccessViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/17/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "MyAccessViewController.h"
#import "AppCommunicate.h"

@interface MyAccessViewController ()
@property (nonatomic, strong)AppCommunicate *communicate;
@end

@implementation MyAccessViewController {
    
    __weak IBOutlet UITextField *registrationTextField;
    __weak IBOutlet UIButton *enterButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _communicate = [[AppCommunicate alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)enterButtonPressed:(id)sender {
    NSDictionary *retrievedData = [_communicate getRegisterInfo:registrationTextField.text];
    if (retrievedData != nil) {
        [[NSUserDefaults standardUserDefaults]setObject:registrationTextField.text forKey:@"userID"];
        [self performSegueWithIdentifier:@"goToUser" sender:@"self"];
        
    }
    NSLog(@"manual");
}
@end
