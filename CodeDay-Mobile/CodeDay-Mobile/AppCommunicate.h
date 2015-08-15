//
//  NSObject+AppCommunicate.h
//  
//
//  Created by Tolga Beser on 8/14/15.
//
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface AppCommunicate : NSObject

-(NSDictionary *)getRegions;

-(NSDictionary *)getEventInfo:(NSString *)eventID;

-(UIImage *)getImage:(NSString *)url;
@end
