//
//  JordanNewsTests.m
//  JordanNewsTests
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"
#import "ArticlesParser.h"
#import "ArticleModel.h"

@interface JordanNewsTests : XCTestCase

@end

@implementation JordanNewsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetArticles {
    XCTestExpectation *expectation = [self expectationWithDescription:@"GET Articles"];
    
    [[ApiManager sharedInstance] getArticlesWithCompletionBlock:^(NSError *error, NSArray *json) {
        // Make sure we downloaded some data.
        XCTAssertNotNil(json, "No data was downloaded.");
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void) testArticlesInitFromDict {
    NSDictionary *jsonDict= @{ @"article": @12345,
                               @"chapo": @"Chapo1",
                               @"comments": @1,
                               @"content": @"Content of article",
                               @"date": @1506939449,
                               @"edit_date": @1506939449,
                               @"image" : @{
                                   @"image_caption": @"Image caption",
                                   @"image_copyright": @"Copyright",
                                   @"image_height": @2,
                                   @"image_title": @"Image title",
                                   @"image_url": @"http://img.bfmtv.com/i/0/0/c0257/885abbd1f3fed5e927e3bfe0360.jpeg",
                                   @"image_width": @2
                               },
                               @"keywords": @"keyword1, keyword2",
                               @"section": @"Section",
                               @"section_id": @42,
                               @"subsection": @"Subsection",
                               @"subsection_id": @"12",
                               @"title": @"Title",
                               @"type": @"Type"
                               };
    
    ArticleModel *article = [[ArticleModel alloc] initWithNSDictionary:jsonDict];
    
    XCTAssertTrue(article.articleId == [jsonDict[@"article"] longValue], @"Articles ID are not equal %ld %ld", article.articleId, [jsonDict[@"article"] longValue]);
    XCTAssertTrue([article.chapo isEqualToString:jsonDict[@"chapo"]],@"Chapos are not equal %@ %@", article.chapo, jsonDict[@"chapo"]);
    XCTAssertTrue(article.nbComments == [jsonDict[@"comments"] intValue], @"Nb comments are not equal %d %d", article.nbComments, [jsonDict[@"comments"] intValue]);
    XCTAssertTrue([article.content isEqualToString:jsonDict[@"content"]],@"Contents are not equal %@ %@", article.content, jsonDict[@"content"]);
    XCTAssertTrue([article.keywords isEqualToString:jsonDict[@"keywords"]],@"Keywords are not equal %@ %@", article.keywords, jsonDict[@"keywords"]);
    XCTAssertTrue([article.section isEqualToString:jsonDict[@"section"]],@"Sections are not equal %@ %@", article.section, jsonDict[@"section"]);
    XCTAssertTrue(article.sectionId == [jsonDict[@"section_id"] longValue], @"Sections ID are not equal %ld %ld", article.sectionId, [jsonDict[@"section_id"] longValue]);
    XCTAssertTrue([article.subsection isEqualToString:jsonDict[@"subsection"]],@"Subsections are not equal %@ %@", article.subsection, jsonDict[@"subsection"]);
    XCTAssertTrue([article.subsectionId isEqualToString:jsonDict[@"subsection_id"]],@"Subsections ID are not equal %@ %@", article.subsectionId, jsonDict[@"subsection_id"]);
    XCTAssertTrue([article.title isEqualToString:jsonDict[@"title"]],@"Titles are not equal %@ %@", article.title, jsonDict[@"title"]);
    XCTAssertTrue([article.type isEqualToString:jsonDict[@"type"]],@"Types are not equal %@ %@", article.type, jsonDict[@"type"]);
    
    //Dates
    NSDate *dateFromDict = [NSDate dateWithTimeIntervalSince1970:[jsonDict[@"date"] doubleValue]];
    NSDate *editDateFromDict = [NSDate dateWithTimeIntervalSince1970:[jsonDict[@"edit_date"] doubleValue]];
    
    XCTAssertTrue([article.date isEqualToDate:dateFromDict],@"Dates are not equal %@ %@", article.date, dateFromDict);
    XCTAssertTrue([article.editDate isEqualToDate:editDateFromDict],@"Edit dates are not equal %@ %@", article.editDate, editDateFromDict);
    
    
    //Image
    XCTAssertTrue([article.image isEqual:jsonDict[@"image"]], @"Images are not equal");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
