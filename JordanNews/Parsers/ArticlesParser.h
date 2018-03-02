//
//  ArticlesParser.h
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticlesParser : NSObject

+ (NSArray *) articlesFromJson:(NSArray *)json;
+ (NSArray *) sortedArticlesFromJson:(NSArray *)json;

@end
