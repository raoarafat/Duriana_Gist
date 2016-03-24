//
//  APIManager+URLHandler.m
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//


#import "APIManager+URLHandler.h"
//#import "StoreDataManager.h"

@implementation APIManager (URLHandler)

#pragma mark CONSTRUCT URL
/* Get NSURL By URL Type */
+ (NSString*)getAPIURL:(APIUrl)urlType
{
    NSString *pathUrl = @"";
    switch (urlType) {
            
            
            
#pragma mark USER
            
        case GistListURL:
            pathUrl = [NSString stringWithFormat:@"%@users/%@/gists?access_token=%@",API_RootURL,[DataManager getUserName],[DataManager getToken]];

            break;
            
        case DeleteGistURL:
            pathUrl = [NSString stringWithFormat:@"%@gists/",API_RootURL];
            
            //DELETE /gists/:id
            
            break;
            
        case StarGistURL:
            pathUrl = [NSString stringWithFormat:@"%@gists/",API_RootURL];
            
            //PUT /gists/:id/star
            //DELETE /gists/:id/star
            
            break;
    }
    return pathUrl;
}


@end
