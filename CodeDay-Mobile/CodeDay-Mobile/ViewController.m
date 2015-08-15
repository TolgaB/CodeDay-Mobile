//
//  ViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/14/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "ViewController.h"
#import "AppCommunicate.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()
@property (nonatomic, strong)AppCommunicate *communicate;
@end

@implementation ViewController {
    NSMutableArray *listOfEventID;
    Reachability *internetReachableFoo;
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
    UIImage *image = [UIImage imageNamed:@"codeday_logo.png"];
    navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    [navBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:navBar];
    [self testInternetConnection];
    
    // Do any additional setup after loading the view, typically from a nib.
}

// Checks if we have an internet connection or not
- (void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self generateRegionButtons]
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                            message:@"You must be connected to the internet to use this app."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        });
    };
    
    [internetReachableFoo startNotifier];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateRegionButtons {
    listOfEventID = [[NSMutableArray alloc] init];
    UIScrollView *mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [mainScroll setBackgroundColor:[UIColor colorWithRed:252/255.0 green:118/255.0 blue:122/255.0 alpha:1.0]];
    NSDictionary *retrievedData = [_communicate getRegions];
    NSMutableArray *retrievedDataArray = retrievedData;
    int lastKnownHeight = 30;
    for (int i =0 ; i < retrievedDataArray.count; i ++) {
        NSDictionary *tempEventDictionary = retrievedDataArray[i];
        NSDictionary *tempEventCurrent = [tempEventDictionary objectForKeyedSubscript:@"current_event"];
        [listOfEventID addObject:[tempEventCurrent objectForKeyedSubscript:@"id"]];
        NSString *eventName = [tempEventDictionary objectForKeyedSubscript:@"name"];
        NSLog(@"%@", eventName);
        UIButton *eventButton = [[UIButton alloc] initWithFrame:CGRectMake(50, lastKnownHeight + 25, self.view.frame.size.width - 100, 30)];
        [eventButton.titleLabel setFont:[UIFont fontWithName:@"Thonburi-Light" size:20]];
        [eventButton setTitleColor:[UIColor colorWithRed:252/255.0 green:118/255.0 blue:122/255.0 alpha:1.0] forState:UIControlStateNormal];
        UIView *backGround = [[UIView alloc] initWithFrame:CGRectMake(50, lastKnownHeight + 0, self.view.frame.size.width - 100, 80)];
        [backGround setBackgroundColor:[UIColor whiteColor]];
        backGround.layer.cornerRadius = 5;
       backGround.layer.masksToBounds = YES;
        backGround.layer.shadowColor = [UIColor blackColor].CGColor;
        backGround.layer.shadowOpacity = 0.1f;
        backGround.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        backGround.layer.shadowRadius = 3.0f;
        backGround.layer.shouldRasterize = NO;
        [backGround.layer setShadowOpacity:5];
        [mainScroll addSubview:backGround];
        eventButton.tag = i;
        [eventButton addTarget:self
                        action:@selector(locationPressed:)
          forControlEvents:UIControlEventTouchUpInside];
         [eventButton setTitle:eventName forState:UIControlStateNormal];
        lastKnownHeight = lastKnownHeight + 100;
        [mainScroll addSubview:eventButton];
    }
    
    [mainScroll setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 43, self.view.frame.size.width, 600)];
    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, lastKnownHeight + 100);
    mainScroll.scrollEnabled = YES;
    [mainScroll removeFromSuperview];
    mainScroll.tag = 8;
    
    [self.view addSubview:mainScroll];
     
}
-(void)locationPressed:(id)sender {
    UIButton *tapRecognizer = (UIButton *)sender;
    int tag = [tapRecognizer tag];
    NSString *theID = listOfEventID[tag];
    [[NSUserDefaults standardUserDefaults] setObject:theID forKey:@"id"];
    [self performSegueWithIdentifier:@"goToEvent" sender:@"Self"];
}
- (BOOL)prefersStatusBarHidden {
    //This hides the annoyign top status bar
    return YES;
}

@end
