
//
//  NSObject+AppCommunicate.m
//  
//
//  Created by Tolga Beser on 8/14/15.
//
//

#import "AppCommunicate.h"

@implementation AppCommunicate
    
-(NSDictionary *)getRegions {
    NSString *restCallString = [NSString stringWithFormat:@"https://clear.codeday.org/api/regions?token=Iw7viYlxCYdRH1Zs6ZXxxKsfWcjv00wH&secret=9h4NdZBPC6B2hx7kNEHJcIEEwCiyWxvS"];
    NSURL *url = [NSURL URLWithString:restCallString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    NSDictionary *retrievedData = [NSJSONSerialization JSONObjectWithData:result
                                                                  options:0
                                                                    error:NULL];
    return retrievedData;
    
    
}
-(NSDictionary *)getEventInfo:(NSString *)eventID {
    NSString *restCallString = [NSString stringWithFormat:@"https://clear.codeday.org/api/event/%@?token=Iw7viYlxCYdRH1Zs6ZXxxKsfWcjv00wH&secret=9h4NdZBPC6B2hx7kNEHJcIEEwCiyWxvS", eventID];
    NSURL *url = [NSURL URLWithString:restCallString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request  returningResponse:&response error:&error];
    NSDictionary *retrievedData = [NSJSONSerialization JSONObjectWithData:result
                                                                  options:0
                                                                    error:NULL];
    return retrievedData;
}

@end
