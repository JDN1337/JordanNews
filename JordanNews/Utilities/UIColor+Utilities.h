//
//  UIColor+Utilities.h
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utilities)

+ (UIColor *) primaryColorBlue;
+ (UIColor *) secondaryColorBlue;
+ (UIColor *) secondaryColorOrange;

+ (UIColor *) colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *) colorFromHexString:(NSString *)hexString;

@end
