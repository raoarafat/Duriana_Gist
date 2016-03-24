//
//  APIManager.h
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "DataManager.h"


FOUNDATION_EXPORT NSString *const API_RootURL;

//@class APIManager;

@interface APIManager : NSObject

#pragma mark USER

+ (void) getGist:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock;

+ (void) deleteGistWithID:(NSString *)gistID startBlock:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock;

+ (void) starGistWithID:(NSString *)gistID isStart:(BOOL)isStar startBlock:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock;

@end
