//
//  JordanNewsTests.m
//  JordanNewsTests
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"

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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
