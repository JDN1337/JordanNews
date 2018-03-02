//
//  ApiManager.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "ApiManager.h"
#import "AFNetworking.h"

@implementation ApiManager

static ApiManager *sharedInstance = nil;

const NSString *apiUrl = @"https://interview-project-api.firebaseio.com";

+ (ApiManager *) sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[ApiManager alloc] init];
    }
    
    return sharedInstance;
}

#pragma mark - GET
//GET ARTICLES
- (void) getArticlesWithCompletionBlock:(void(^)(NSError *error, NSArray *json))completion{
    NSString *articlesUrl = [NSString stringWithFormat:@"%@/contents.json", apiUrl];
    
    [self makeHTTPGetRequestWithUrl:articlesUrl andCompletionBlock:^(NSError *error, id responseObject) {
        if(error) {
            completion(error, nil);
        }
        else{
            completion(nil, responseObject);
        }
    }];
}

#pragma mark - Generic requests
//GET REQUEST
- (void) makeHTTPGetRequestWithUrl:(NSString *)url andCompletionBlock:(void(^)(NSError *error, id responseObject))completion{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
    
    //    NSLog(@"GET: %@", url);
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(error, nil);
    }];
}

@end
