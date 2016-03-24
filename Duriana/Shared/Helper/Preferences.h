//
//  Preferences.h
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Preferences : NSObject

/*
 Get Build Version Text Eample : © by Seeka 2015. Build 1.0
 */
+(NSString*)getBuildVersionText;

+(void)setPreferencesWithKey:(NSString*)key value:(NSString*)value;
+(NSString*)getPreferencesWithKey:(NSString*)key;
+(void)setPreferencesIntWithKey:(NSString*)key value:(int)value;
+(int)getPreferencesIntWithKey:(NSString*)key;
+(void)setPreferencesFloatWithKey:(NSString*)key value:(float)value;
+(int)getPreferencesIntWithKey:(NSString*)key defaultValue:(int)defaultvalue;
+(float)getPreferencesFloatWithKey:(NSString*)key;
+(BOOL)getPreferencesBoolWithKey:(NSString*)key;
+(BOOL)getPreferencesBoolWithKey:(NSString*)key defaultValue:(BOOL)defaultValue;
+(void)setPreferencesBoolWithKey:(NSString*)key value:(BOOL)value;

+(BOOL)isIPad;


+ (void) setPreferencesArrayWithKey:(NSMutableArray *)array key:(NSString*)key;
+ (NSMutableArray* ) getPreferencesArrayWithKey:(NSString*)key;


+ (void) setPreferencesDictinaryWithKey:(NSMutableDictionary *)dictionary key:(NSString*)key;
+ (NSMutableDictionary* ) getPreferencesDictinaryWithKey:(NSString*)key;



@end
