//
//  ViewUtilities.m
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import "ViewUtilities.h"

@implementation ViewUtilities

+(void)roundingUIView:(UIView*)roundView
{
    [self roundingUIView:roundView cornerRadius:5.0f];
}


+(void)roundingUIView:(UIView*)roundView cornerRadius:(float)cornerRadius
{
    roundView.layer.cornerRadius = cornerRadius;
    roundView.layer.masksToBounds = YES;
}

+(void)borderingUIView:(UIView*)roundView color:(UIColor*)borderColor tick:(float)borderWidth
{
    roundView.layer.borderColor = borderColor.CGColor;
    roundView.layer.borderWidth = borderWidth;
}

+(float)getScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+(float)getScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

@end
