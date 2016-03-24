//
//  ViewUtilities.h
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewUtilities : NSObject

+(void)roundingUIView:(UIView*)roundView;
+(void)roundingUIView:(UIView*)roundView cornerRadius:(float)cornerRadius;
+(void)borderingUIView:(UIView*)roundView color:(UIColor*)borderColor tick:(float)borderWidth;

+(float)getScreenWidth;
+(float)getScreenHeight;


@end
