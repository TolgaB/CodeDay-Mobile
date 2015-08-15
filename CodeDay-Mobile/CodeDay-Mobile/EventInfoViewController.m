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
#import <MapKit/MapKit.h>
@interface EventInfoViewController ()
@property (nonatomic, strong)AppCommunicate *communicate;
@end
@implementation EventInfoViewController {
    NSDictionary *retrievedData;
    IBOutlet UIButton *schedule;
    IBOutlet UIButton *contact;
    IBOutlet UIButton *emergency;
    IBOutlet UIButton *waiver;
    IBOutlet UIButton *buyticket;
    IBOutlet UIButton *location;
    IBOutlet UIButton *sponsors;
    IBOutlet UIButton *awards;
    __weak IBOutlet UILabel *eventNameLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _communicate = [[AppCommunicate alloc] init];
    [self retrieveInfo];
    [self fix];
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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed)];
    navigationItem.leftBarButtonItem = backButton;;
    [navBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:navBar];
    
}


-(void) fix
{

    

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float margin = screenRect.size.width - schedule.frame.size.width - schedule.frame.size.width;
    margin = margin/3;
    [self fixButton:schedule withMargin:margin];
    [self fixButton:emergency withMargin:margin];
    [self fixButton:buyticket withMargin:margin];
    [self fixButton:sponsors withMargin:margin];
    
    [self fixButton2:contact withMargin:margin];
    [self fixButton2:waiver withMargin:margin];
    [self fixButton2:location withMargin:margin];
    [self fixButton2:awards withMargin:margin];
    
}

-(void) fixButton:(UIButton*) button withMargin:(float) margin
{
    button.frame = (CGRect){margin, button.frame.origin.y,button.frame.size.width,button.frame.size.height};
}

-(void) fixButton2:(UIButton*) button withMargin:(float) margin
{
    button.frame = (CGRect){margin + button.frame.size.width + margin, button.frame.origin.y,button.frame.size.width,button.frame.size.height};
}



- (IBAction)scheduleButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"goToSchedule" sender:@"self"];
}

- (IBAction)emergencyButtonPressed:(id)sender {
    NSURL *phoneNumber = [[NSURL alloc] initWithString: @"tel:18882633230"];
    [[UIApplication sharedApplication] openURL: phoneNumber];
}

- (IBAction)buyTicketButtonPressed:(id)sender {
    NSDictionary *resulting = [retrievedData objectForKeyedSubscript:@"urls"];
    if ([resulting objectForKeyedSubscript:@"register"] != [NSNull null]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[resulting objectForKeyedSubscript:@"register"]]];
    }
    else {
        UIView *contentView = [[UIView alloc] init];
        contentView.frame = CGRectMake(0, 0, 200, 80);
        contentView.backgroundColor = [UIColor whiteColor];
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 30, 300, 30)];
        [errorLabel setText:@"Tickets Not Avalaible"];
        [contentView addSubview:errorLabel];
        KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
        [popup show];
    }
}
- (IBAction)sponsorButtonPressed:(id)sender {
    UIView* contentView;
    int newHeight = 0;
    NSMutableArray *sponsorArray = [retrievedData objectForKeyedSubscript:@"sponsors"];
    if (sponsorArray.count > 0) {
        UIView *contentView = [[UIView alloc] init];
         contentView.frame = CGRectMake(0.0, 0.0, 250.0, 400.0);
         UIScrollView *mainScroll = [[UIScrollView alloc] initWithFrame:contentView.frame];
    for (int l = 0; l < sponsorArray.count; l ++) {
        NSDictionary *tempEventInfo = sponsorArray[l];
        UIImage *logo = [_communicate getImage:[tempEventInfo objectForKeyedSubscript:@"logo"]];
        NSString *name = [tempEventInfo objectForKeyedSubscript:@"name"];
        contentView.backgroundColor = [UIColor whiteColor];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, newHeight + 30, 180, 30)];
        UIImageView *sponsorImage = [[UIImageView alloc] initWithFrame:CGRectMake(70, newHeight + 70, 100, 100)];
        sponsorImage.image = logo;
        newHeight = newHeight + 200;
        [nameLabel setText:name];
        [nameLabel setTextColor:[UIColor blackColor]];
        [contentView addSubview:sponsorImage];
        [contentView addSubview:nameLabel];
        [nameLabel layoutIfNeeded];
        [nameLabel sizeToFit];
        [mainScroll addSubview:contentView];
    }
        mainScroll.contentSize = CGSizeMake(250.0, newHeight + 50);
        [mainScroll setBackgroundColor:[UIColor whiteColor]];
        mainScroll.scrollEnabled = YES;
        [mainScroll removeFromSuperview];
        mainScroll.tag = 8;
        

        KLCPopup* popup = [KLCPopup popupWithContentView:mainScroll];
        [popup show];
    }
    else {
        UIView *contentView = [[UIView alloc] init];
        contentView.frame = CGRectMake(0, 0, 150, 80);
        contentView.backgroundColor = [UIColor whiteColor];
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 30, 300, 30)];
        [errorLabel setText:@"No Sponsors"];
        [contentView addSubview:errorLabel];
        KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
        [popup show];
    }
    NSLog(@"manual");
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
    else {
        contentView.frame = CGRectMake(0, 0, 200, 80);
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 150, 30)];
        [errorLabel setText:@"No Data Found"];
        [contentView addSubview:errorLabel];
    }

    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
    [popup show];
}
- (IBAction)waiverButtonPressed:(id)sender {
    if ([retrievedData objectForKeyedSubscript:@"waiver"] != [NSNull null]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[retrievedData objectForKeyedSubscript:[retrievedData objectForKeyedSubscript:@"waiver"]]]];
    }
    else {
        UIView* contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.frame = CGRectMake(0, 0, 200, 80);
        UILabel *errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 150, 30)];
        [errorLabel setText:@"No Waiver"];
        [contentView addSubview:errorLabel];
        KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
        [popup show];
    }
}
- (IBAction)locationButtonPressed:(id)sender {
    NSDictionary *regionDictionary = [retrievedData objectForKeyedSubscript:@"region"];
    NSDictionary *locationDictionary = [regionDictionary objectForKeyedSubscript:@"location"];
    NSString *latitude = [locationDictionary objectForKeyedSubscript:@"lat"];
    NSString *longitude = [locationDictionary objectForKeyedSubscript:@"lng"];
    NSLog(@"manual");
    UIView* contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.frame = CGRectMake(0, 0, 250, 400);
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:contentView.frame];
    CLLocationCoordinate2D c2D = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = c2D;
    myAnnotation.title = @"CodeDay";
    [mapView addAnnotation:myAnnotation];
    mapView.region = MKCoordinateRegionMakeWithDistance(c2D, 15000, 15000);
    [contentView addSubview:mapView];
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView];
    [popup show];
    

    
}

- (BOOL)prefersStatusBarHidden {
    //This hides the annoyign top status bar
    return YES;
}
-(void)backButtonPressed {
    [self performSegueWithIdentifier:@"eventToMain" sender:@"self"];
}

@end
