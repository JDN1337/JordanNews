//
//  ArticlesParser.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "ArticlesParser.h"
#import "ArticleModel.h"

@implementation ArticlesParser

+ (NSArray *) articlesFromJson:(NSArray *)json {
    NSMutableArray *articlesList = [[NSMutableArray alloc] init];
    
    //Contents
    if (json && [json count] > 0){
        for (NSDictionary *content in json) {
            
            //Elements
            NSArray *elementsList = [content objectForKey:@"elements"];
            if(elementsList && [elementsList count] > 0){
                for(NSDictionary *element in elementsList){
                    
                    //Items
                    NSArray *itemsList = [element objectForKey:@"items"];
                    if(itemsList && [itemsList count] > 0){
                        for(NSDictionary *item in itemsList){
                            ArticleModel *article = [[ArticleModel alloc] initWithNSDictionary:item];
                            [articlesList addObject:article];
                        }
                    }
                }
            }
        }
    }
    
    return articlesList;
}

+ (NSArray *) sortedArticlesFromJson:(NSArray *)json {
    //Order by date
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortedArticlesList = [[self articlesFromJson:json] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return sortedArticlesList;
}

@end
