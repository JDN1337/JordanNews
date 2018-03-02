//
//  ArticlesTableViewController.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "ArticlesTableViewController.h"
#import "ApiManager.h"
#import "ArticlesParser.h"
#import "ArticleModel.h"
#import "ArticleDetailViewController.h"

@interface ArticlesTableViewController ()

@property (strong, nonatomic) NSArray* articlesList;

@end

@implementation ArticlesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_articlesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell" forIndexPath:indexPath];
    
    ArticleModel *article = [_articlesList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = article.title;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showArticleDetail"]){
        ArticleDetailViewController *destVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        destVC.article = [_articlesList objectAtIndex:indexPath.row];
    }
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
            
            if(!_articlesList){
                _articlesList = [[NSArray alloc] init];
            }
            
            //Parse JSON to get a list of articles
            _articlesList = [ArticlesParser sortedArticlesFromJson:json];
        }
        
        [self.tableView reloadData];
    }];
}

@end
