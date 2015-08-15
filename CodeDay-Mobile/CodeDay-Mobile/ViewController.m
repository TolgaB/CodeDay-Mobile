//
//  ViewController.m
//  CodeDay-Mobile
//
//  Created by Tolga Beser on 8/14/15.
//  Copyright (c) 2015 Tolga Beser. All rights reserved.
//

#import "ViewController.h"
#import "AppCommunicate.h"

@interface ViewController ()
@property (nonatomic, strong)AppCommunicate *communicate;
@end

@implementation ViewController {
    NSMutableArray *listOfEventID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _communicate = [[AppCommunicate alloc] init];
    [self generateRegionButtons];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)generateRegionButtons {
    listOfEventID = [[NSMutableArray alloc] init];
    UIScrollView *mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSDictionary *retrievedData = [_communicate getRegions];
    NSMutableArray *retrievedDataArray = retrievedData;
    int lastKnownHeight = 0;
    for (int i =0 ; i < retrievedDataArray.count; i ++) {
        NSDictionary *tempEventDictionary = retrievedDataArray[i];
        NSDictionary *tempEventCurrent = [tempEventDictionary objectForKeyedSubscript:@"current_event"];
        [listOfEventID addObject:[tempEventCurrent objectForKeyedSubscript:@"id"]];
        NSString *eventName = [tempEventDictionary objectForKeyedSubscript:@"name"];
        NSLog(@"%@", eventName);
        UIButton *eventButton = [[UIButton alloc] initWithFrame:CGRectMake(40, lastKnownHeight + 80, 300, 30)];
        eventButton.tag = i;
        [eventButton addTarget:self
                        action:@selector(locationPressed:)
          forControlEvents:UIControlEventTouchUpInside];
         [eventButton setTitle:eventName forState:UIControlStateNormal];
        [eventButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        lastKnownHeight = lastKnownHeight + 100;
        [mainScroll addSubview:eventButton];
    }
    
    [mainScroll setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 43, self.view.frame.size.width, 600)];
    mainScroll.contentSize = CGSizeMake(self.view.frame.size.width, lastKnownHeight + 300);
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

@end
