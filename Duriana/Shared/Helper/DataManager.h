//
//  DataManager.h
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DataManager : NSObject

+ (DataManager *)sharedInstance;


+(void) setToken:(NSString *) value;
+(NSString *)getToken;

+(void) setUserName:(NSString *) value;
+(NSString *)getUserName;

@end
