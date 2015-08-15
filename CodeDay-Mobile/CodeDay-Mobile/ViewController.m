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

@implementation ViewController

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
    NSDictionary *retrievedData = [_communicate getRegions];
    NSMutableArray *retrievedDataArray = retrievedData;
    int lastKnownHeight = 0;
    for (int i =0 ; i < retrievedDataArray.count; i ++) {
        NSDictionary *tempEventDictionary = retrievedDataArray[i];
        NSString *eventName = [tempEventDictionary objectForKeyedSubscript:@"name"];
        NSLog(@"%@", eventName);
        UIButton *eventButton = [[UIButton alloc] initWithFrame:CGRectMake(40, lastKnownHeight + 80, 300, 30)];
        [eventButton addTarget:self
                    action:NULL
          forControlEvents:UIControlEventTouchUpInside];
         [eventButton setTitle:eventName forState:UIControlStateNormal];
        [eventButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        lastKnownHeight = lastKnownHeight + 100;
        [self.view addSubview:eventButton];
    }
}

@end
