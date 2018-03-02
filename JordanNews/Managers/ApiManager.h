//
//  ApiManager.h
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

+ (ApiManager *) sharedInstance;

//GET
- (void) getArticlesWithCompletionBlock:(void(^)(NSError *error, NSArray *json))completion;

//POST

//PUT

//DELETE

@end
