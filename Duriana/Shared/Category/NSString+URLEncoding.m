//
//  NSString+URLEncoding.m
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding {

    NSCharacterSet *URLBase64CharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"`~%^-_.|!*'\"();:@&=+$,/?%#[]% "] invertedSet];
    NSString * escapedValue = [self stringByAddingPercentEncodingWithAllowedCharacters:URLBase64CharacterSet];

    return escapedValue;
}
@end
