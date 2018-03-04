//
//  NSDate+Utilities.h
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)

+ (NSDate *) dateFromString:(NSString* )stringDate WithFormatter:(NSString *)stringFormatter;
- (NSString *) stringFromDateWithFormatter:(NSString *)stringFormatter;

@end
