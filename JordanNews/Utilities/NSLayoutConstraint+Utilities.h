//
//  NSLayoutConstraint+Utilities.h
//  JordanNews
//
//  Created by Jordan Lepretre on 04/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Utilities)

+ (void)updateAspectRatioConstraint:(NSLayoutConstraint *)constraint withMultiplier: (float)multiplier fromView:(UIView *)view;

@end
