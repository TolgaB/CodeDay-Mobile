//
//  FrontPageViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/17/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "FrontPageViewController.h"

@implementation FrontPageViewController {
    
    __weak IBOutlet UIButton *eventsButton;
    __weak IBOutlet UIButton *myCodeDayButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)myCodeDayButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToAccess" sender:@"self"];
}
- (IBAction)eventsButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToEventFromFront" sender:@"self"];
}

@end
