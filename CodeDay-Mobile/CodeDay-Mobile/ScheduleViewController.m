//
//  ScheduleViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/14/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "ScheduleViewController.h"
#import "AppCommunicate.h"
@interface ScheduleViewController ()
@property (nonatomic, strong)AppCommunicate *communicate;
@end
@implementation ScheduleViewController {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _communicate = [[AppCommunicate alloc] init];
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    [navBar setFrame:CGRectMake(0,0,screenWidth,(screenHeight/13))];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.title =  @"Schedule";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed)];
    navigationItem.leftBarButtonItem = backButton;;
    [navBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:navBar];
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData {
    UIScrollView *mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSDictionary *retrievedData = [_communicate getEventInfo:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
    NSDictionary *scheduleDictionary = [retrievedData objectForKeyedSubscript:@"schedule"];
    NSMutableArray *saturdayArray = [scheduleDictionary objectForKeyedSubscript:@"Saturday"];
    NSMutableArray *sundayArray = [scheduleDictionary objectForKeyedSubscript:@"Sunday"];
    int currentHeight = 0;
    for (int i = 0; i < saturdayArray.count; i++) {
        if (i == 0)
        {
            UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 300, 30)];
            [headLabel setText:@"Saturday"];
            [mainScroll addSubview:headLabel];
            [headLabel setTextColor:[UIColor whiteColor]];
        }
        NSDictionary *tempSchedule = saturdayArray[i];
        NSString *timeString = [tempSchedule objectForKeyedSubscript:@"hour"];
        NSString *titleString = [tempSchedule objectForKeyedSubscript:@"title"];
        NSString *finalString = [NSString stringWithFormat:@"%@: %@", timeString, titleString];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, currentHeight + 70, 300, 30)];
        [timeLabel setTextColor:[UIColor whiteColor]];
        currentHeight = currentHeight + 50;
        [timeLabel setText:finalString];
        [mainScroll addSubview:timeLabel];
    }
    for (int u = 0; u < sundayArray.count; u++) {
        if (u == 0)
        {
            UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, currentHeight + 50, 300, 30)];
            currentHeight = currentHeight + 10;
            [headLabel setText:@"Sunday"];
            [headLabel setTextColor:[UIColor whiteColor]];
            [mainScroll addSubview:headLabel];
        }
        NSDictionary *tempSchedule = sundayArray[u];
        NSString *timeString = [tempSchedule objectForKeyedSubscript:@"hour"];
        NSString *titleString = [tempSchedule objectForKeyedSubscript:@"title"];
        NSString *finalString = [NSString stringWithFormat:@"%@: %@", timeString, titleString];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, currentHeight + 70, 300, 30)];
        [timeLabel setTextColor:[UIColor whiteColor]];
        currentHeight = currentHeight + 50;
        [timeLabel setText:finalString];
        [mainScroll addSubview:timeLabel];
    }
    [mainScroll setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 43, self.view.frame.size.width, 600)];
    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, currentHeight + 150);
    mainScroll.scrollEnabled = YES;
    [mainScroll removeFromSuperview];
    mainScroll.tag = 8;
    
    [self.view addSubview:mainScroll];
    NSLog(@"manual");
}
-(void)backButtonPressed {
    [self performSegueWithIdentifier:@"goToEventFromSchedule" sender:@"self"];
}
- (BOOL)prefersStatusBarHidden {
    //This hides the annoyign top status bar
    return YES;
}
@end
