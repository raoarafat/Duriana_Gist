//
//  Preferences.m
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

/*
 Get Build Version Text Eample : © by Seeka 2015. Build 1.0
 */
+(NSString*)getBuildVersionText
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    
    return [NSString stringWithFormat:@"Copyright by SEEKA 2016. Version : %@ (%@)",version,build];
}



+(void)setPreferencesWithKey:(NSString*)key value:(NSString*)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+(NSString*)getPreferencesWithKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(defaults!=nil){
        return [defaults objectForKey:key];
    }else{
        return @"";
    }
}
+(void)setPreferencesIntWithKey:(NSString*)key value:(int)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:key];
    [defaults synchronize];
}

+(int)getPreferencesIntWithKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(defaults!=nil){
        return [defaults floatForKey:key];
    }else{
        return 0;
    }
}

+(int)getPreferencesIntWithKey:(NSString*)key defaultValue:(int)defaultvalue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(defaults!=nil){
        return [defaults floatForKey:key];
    }else{
        return defaultvalue;
    }
}

+(void)setPreferencesFloatWithKey:(NSString*)key value:(float)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:key];
    [defaults synchronize];
}
+(float)getPreferencesFloatWithKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(defaults!=nil){
        return [defaults floatForKey:key];
    }else{
        return 0;
    }
}

+(void)setPreferencesBoolWithKey:(NSString*)key value:(BOOL)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
}

+(BOOL)getPreferencesBoolWithKey:(NSString*)key
{
    return [self getPreferencesBoolWithKey:key defaultValue:NO];
}

+(BOOL)getPreferencesBoolWithKey:(NSString*)key defaultValue:(BOOL)defaultValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(defaults!=nil){
        return [defaults boolForKey:key];
    }else{
        return defaultValue;
    }
}


+(BOOL)isIPad
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return YES; /* Device is iPad */
    }else{
        return NO;
    }
}

+ (void) setPreferencesArrayWithKey:(NSMutableArray *)array key:(NSString*)key{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:array];
    
    [defaults setObject:dataSave forKey:key];
    [defaults synchronize];
}

+ (NSMutableArray * ) getPreferencesArrayWithKey:(NSString*)key{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if(defaults!=nil){
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return (NSMutableArray *)savedArray;
        
    }
    
    return nil;
    
}

+ (void) setPreferencesDictinaryWithKey:(NSMutableArray *)dictionary key:(NSString*)key{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    
    [defaults setObject:dataSave forKey:key];
    [defaults synchronize];
}

+ (NSMutableDictionary * ) getPreferencesDictinaryWithKey:(NSString*)key{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if(defaults!=nil){
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        NSDictionary *savedDictioanry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return (NSMutableDictionary *)savedDictioanry;
        
    }
    
    return nil;
    
}

@end
