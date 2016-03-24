//
//  DataManager.m
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//


#import "DataManager.h"
#import "Preferences.h"

@implementation DataManager

/* Using GCD Dispatch QUEUE */
+ (DataManager *)sharedInstance {
    static DataManager *sharedGloble = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGloble = [[self alloc] init];
    });
    return sharedGloble;
}

#pragma mark - init
-(id) init
{
    if (self = [super init])
    {
        
    }
    return self;
}

+(void) setToken:(NSString *) value{
    [Preferences setPreferencesWithKey:@"CONF_TOKEN" value:value];
}
+(NSString *)getToken{
    return [Preferences getPreferencesWithKey:@"CONF_TOKEN"];;
}

+(void) setUserName:(NSString *) value{
    [Preferences setPreferencesWithKey:@"CONF_USER_NAME" value:value];
}
+(NSString *)getUserName{
    return [Preferences getPreferencesWithKey:@"CONF_USER_NAME"];;
}


@end
