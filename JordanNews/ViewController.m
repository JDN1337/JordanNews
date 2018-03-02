//
//  ViewController.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "ViewController.h"
#import "ApiManager.h"
#import "ArticlesParser.h"
#import "ArticleModel.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray* articlesList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadArticles];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - API Management
- (void) loadArticles{
    //Get articles
    [[ApiManager sharedInstance] getArticlesWithCompletionBlock:^(NSError *error, NSArray *json) {
        if(error) {
            NSLog(@"Error: %@", error);
                
            //Show error alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oups :(" message:@"Une erreur s'est produite ! Veuillez réessayez plus tard."preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
//            NSLog(@"JSON : %@", json);
            
            //Parse JSON to get a list of articles
            if(!_articlesList){
                _articlesList = [[NSArray alloc] init];
            }
            
            _articlesList = [ArticlesParser sortedArticlesFromJson:json];
            
            for(int i = 0; i < [_articlesList count]; i++){
                ArticleModel *article = (ArticleModel *)[_articlesList objectAtIndex:i];
                NSLog(@"Article %ld - Date : %@", article.articleId, article.date);
            }
        }
    }];
}


@end
