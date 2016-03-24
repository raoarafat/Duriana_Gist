//
//  UIColor+UIColor.h
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor)

/*
pragma mark Get UIColor form NSString (Hex)
 */
+ (UIColor*)colorWithHexString:(NSString*)hex;

/*
 pragma mark Get UIColor form NSString (Hex) and Alpha float
 */
+ (UIColor*)colorWithHexString:(NSString*)hex alpha:(float)alpha;

@end
