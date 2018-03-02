//
//  ArticleModel.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

- (id) initWithNSDictionary:(NSDictionary *)dict{
    self = [super init];
    
    if(dict){
        self.articleId = [dict[@"article"] longValue];
        self.chapo = dict[@"chapo"];
        self.nbComments = [dict[@"comments"] intValue];
        self.content = dict[@"content"];
        self.keywords = dict[@"keywords"];
        self.section = dict[@"section"];
        self.sectionId = [dict[@"section_id"] longValue];
        self.subsection = dict[@"subsection"];
        self.subsectionId = dict[@"subsection_id"];
        self.title = dict[@"title"];
        self.type = dict[@"type"];
        
        //Dates
        self.date = [NSDate dateWithTimeIntervalSince1970:[dict[@"date"] doubleValue]];
        self.editDate = [NSDate dateWithTimeIntervalSince1970:[dict[@"edit_date"] doubleValue]];
        
        //Image
        self.image = dict[@"image"];
        
        //Image URL
        NSString *imgUrlString = [self.image objectForKey:@"image_url"];
        //App Transport Security has blocked a cleartext HTTP, replace it by https
        if([imgUrlString hasPrefix:@"http://"]){
            imgUrlString = [imgUrlString stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        }
        
        self.imageUrl = [NSURL URLWithString:imgUrlString];
    }
    
    return self;
}

@end
