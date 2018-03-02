//
//  ArticleModel.h
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property long articleId;
@property (nonatomic, strong) NSString *chapo;
@property int nbComments;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *editDate;
@property (nonatomic, strong) NSDictionary *image;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *section;
@property long sectionId;
@property (nonatomic, strong) NSString *subsection;
@property (nonatomic, strong) NSString *subsectionId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;

- (id) initWithNSDictionary:(NSDictionary *)dict;

@end
