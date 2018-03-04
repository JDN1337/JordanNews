//
//  NSLayoutConstraint+Utilities.m
//  JordanNews
//
//  Created by Jordan Lepretre on 04/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "NSLayoutConstraint+Utilities.h"

@implementation NSLayoutConstraint (Utilities)


+ (void)updateAspectRatioConstraint:(NSLayoutConstraint *)constraint withMultiplier: (float)multiplier fromView:(UIView *)view {    
    [view removeConstraint: constraint];
    constraint = [NSLayoutConstraint constraintWithItem: constraint.firstItem
                                        attribute: constraint.firstAttribute
                                        relatedBy: constraint.relation
                                           toItem: constraint.secondItem
                                        attribute: constraint.secondAttribute
                                       multiplier: multiplier
                                         constant: 0.0];
    
    [view addConstraint: constraint];
}

@end
