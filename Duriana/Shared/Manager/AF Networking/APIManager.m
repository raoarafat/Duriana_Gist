//
//  APIManager.m
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//


#import "APIManager.h"
#import <objc/runtime.h>
#import "APIManager+URLHandler.h"
#import "NSString+URLEncoding.h"


NSString *const API_RootURL = @"https://api.github.com/";
NSString *const Method_POST = @"POST";
NSString *const Method_PUT = @"PUT";
NSString *const Method_DELETE = @"DELETE";


@implementation APIManager

#pragma mark - API CALLS

#pragma mark Get Gist


+ (void) getGist:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock
{
    NSString *url = [self getAPIURL:GistListURL];
    [self GET:url params:nil startBlock:startBlock failedBlock:failedBlock successBlock:successBlock];
    
    //https://api.github.com/users/raoarafat/gists?access_token=10c89ff004af24281e7aaf49a00edd577ffa9831
}

#pragma mark Delete Gist

+ (void) deleteGistWithID:(NSString *)gistID startBlock:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@",[self getAPIURL:DeleteGistURL],gistID,[DataManager getToken]];
    
    [APIManager POSTRawRequestWithURL:url params:Nil method:Method_DELETE startBlock:startBlock failedBlock:failedBlock successBlock:successBlock];
    
}

#pragma mark Star & UnStar Gist

+ (void) starGistWithID:(NSString *)gistID isStart:(BOOL)isStar startBlock:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock{
    
    NSString * httpMethod;
    
    if (isStar) {
        httpMethod = Method_PUT;
    }else{
        httpMethod = Method_DELETE;
    }
    
    ////DELETE /gists/:id/star
    
    NSString *url = [NSString stringWithFormat:@"%@%@/star?access_token=%@",[self getAPIURL:StarGistURL],gistID,[DataManager getToken]];
    
    [APIManager POSTRawRequestWithURL:url params:Nil method:httpMethod startBlock:startBlock failedBlock:failedBlock successBlock:successBlock];
    
}

#pragma mark - HELPER

/* Helper: Given raw Object (Array OR Dictionary), return a JSON string */
+ (NSString *)parseObjectIntoJSONString:(id)params {
    
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}

/* Helper: Given raw JSON, return a usable Foundation object */
+ (NSDictionary *) parseJSONWithData:(NSData *)data {
    
    NSError *parsingError = nil;
    
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parsingError];
    
    return json;
}


/* Helper function: Given a dictionary of parameters, convert to a string for a url */

+ (NSString *) escapedParameters:(NSDictionary *)parameters{
    
    NSString *urlVars = [[NSString alloc]init];
    
    int i = 0;
    
    for (NSString *key in parameters)
    {
        NSString * escapedValue = [[parameters valueForKey:key] urlEncodeUsingEncoding];
        
        /* Append it */
        if (i == 0)
        {urlVars = [urlVars stringByAppendingFormat:@"?%@=%@",key, escapedValue];}
        else
        {urlVars = [urlVars stringByAppendingFormat:@"&%@=%@",key, escapedValue];}
        i++;
    }
    return [NSString stringWithFormat:@"%@",[self isEmpty:urlVars] ? @"" : urlVars] ;
}

+ (BOOL) isEmpty:(NSString *)string{
    return ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0);
}


#pragma mark - REQUEST API

/* GET */

+ (void)GET:(NSString*)url params:(NSDictionary*)params startBlock:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock
{
    startBlock();
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"url : %@",url);
    [manager GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSDictionary *json = (NSDictionary*)responseObject;

         if(json.count > 0){
             successBlock(@"Success",json);
         }else{
             failedBlock(@404,@"failed");
         }
     } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         failedBlock(@101,[error localizedDescription]);
     }];
}

/* POST */

+ (AFHTTPRequestOperation *)POSTRawRequestWithURL:(NSString*)url params:(NSDictionary*)params method:(NSString*)method startBlock:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock
{
    startBlock();
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    
    NSError *jsonDataError = nil;
    [request setHTTPMethod:method];
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:0 error:&jsonDataError]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSDictionary *json = (NSDictionary*)responseObject;
        BOOL success = YES;
        if(success){
            successBlock(@"Success",json);
        }else{
            failedBlock(@404,@"Error");
        }
        
        NSLog(@"JSON responseObject: %@ ",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        failedBlock(@101,[error localizedDescription]);
        
        
    }];
    [operation start];
    return operation;
    
}


+ (void)POSTFormRequestWithURL:(NSString*)url params:(NSDictionary*)params method:(NSString*)method startBlock:(void (^)(void))startBlock failedBlock:(void (^)(NSNumber*errorCode, NSString*message))failedBlock successBlock:(void (^)(NSString* message, NSDictionary *data))successBlock
{
    startBlock();
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"url : %@",url);
    [manager POST:url parameters:params method:method
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSDictionary *json = (NSDictionary*)responseObject;
         BOOL success = [[json objectForKey:@"status"] boolValue];
         NSString *message = [json objectForKey:@"message"];
         NSNumber *code = [json objectForKey:@"code"];
         if(success){
             successBlock(message,json);
         }else{
             failedBlock(code,message);
         }
     } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         failedBlock(@101,[error localizedDescription]);
     }];
}

@end
