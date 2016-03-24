//
//  APIManager+URLHandler.h
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//


#import "APIManager.h"


typedef NS_ENUM(NSInteger, APIUrl)
{
    GistListURL = 0,
    StarGistURL,
    DeleteGistURL
    
};


@interface APIManager (URLHandler)


+ (NSString*)getAPIURL:(APIUrl)urlType;

@end
