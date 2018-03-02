//
//  NSDate+Utilities.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

+ (NSDate *) dateFromString:(NSString *)stringDate WithFormatter:(NSString *)stringFormatter{
    if(!stringDate || [stringDate isEqual:[NSNull null]] || [stringDate isEqualToString:@""]){
        return [NSDate dateWithTimeIntervalSince1970:0];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:stringFormatter];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CET"]];
    
    return [formatter dateFromString:stringDate];
}

- (NSString *) stringFromDatewithFormatter:(NSString *)stringFormatter{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:stringFormatter];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CET"]];
    
    return [formatter stringFromDate:self];
}

@end
