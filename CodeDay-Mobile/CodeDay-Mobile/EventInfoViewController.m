//
//  EventInfoViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/14/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "EventInfoViewController.h"
#import "AppCommunicate.h"
#import "KLCPopup.h"
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
- (IBAction)scheduleButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToSchedule" sender:@"self"];
}

- (IBAction)emergencyButtonPressed:(id)sender {
}

- (IBAction)buyTicketButtonPressed:(id)sender {
}
- (IBAction)sponsorButtonPressed:(id)sender {
}

- (IBAction)contactButtonPressed:(id)sender {
    UIView* contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.frame = CGRectMake(0.0, 0.0, 250.0, 200.0);
    if ([retrievedData objectForKeyedSubscript:@"manager"] != [NSNull null]) {
    NSDictionary *managerDictionary = [retrievedData objectForKeyedSubscript:@"manager"];
    NSString *name = [managerDictionary objectForKeyedSubscript:@"name"];
    NSString *email = [managerDictionary objectForKeyedSubscript:@"email"];
    NSString *phone = [managerDictionary objectForKeyedSubscript:@"phone"];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 200, 30)];
    [nameLabel setText:name];
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 200, 30)];
        [emailLabel setText:email];
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 200, 30)];
        [phoneLabel setText:phone];
        [contentView addSubview:nameLabel];
        [contentView addSubview:emailLabel];
        [contentView addSubview:phoneLabel];
    }

    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
    [popup show];
}
- (IBAction)waiverButtonPressed:(id)sender {
}
- (IBAction)locationButtonPressed:(id)sender {
}
- (IBAction)awardsButton:(id)sender {
}

@end
