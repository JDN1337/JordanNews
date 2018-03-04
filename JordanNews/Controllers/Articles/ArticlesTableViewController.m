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
#import "UIColor+Utilities.h"
#import "ArticleTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+Utilities.h"
#import "NSLayoutConstraint+Utilities.h"

@interface ArticlesTableViewController ()

@property (strong, nonatomic) NSArray* articlesList;
@property BOOL isLoadingNews; //YES if loadArticles is in progress (used to avoid multiple requests)

@end

@implementation ArticlesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isLoadingNews = NO;
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor secondaryColorBlue];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(loadArticles)
                  forControlEvents:UIControlEventValueChanged];
    
    //Programmatically pull to refresh
#warning TODO FIX
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){
        self.tableView.contentOffset = CGPointMake(0, -self.refreshControl.frame.size.height);
    } completion:^(BOOL finished) {
        [self.refreshControl beginRefreshing];
    }];
    
    //Load datas
    [self loadArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([_articlesList count] > 0){
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        return [_articlesList count];
    }
    else{
        if(!_isLoadingNews){
            // Display a message when the table is empty
            UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            
            messageLabel.text = @"Aucune actualité disponible.\nVeuillez glisser vers le bas pour rafraîchir.";
            messageLabel.textColor = [UIColor blackColor];
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = NSTextAlignmentCenter;
            messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
            [messageLabel sizeToFit];
            
            self.tableView.backgroundView = messageLabel;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell" forIndexPath:indexPath];
    
    ArticleModel *article = [_articlesList objectAtIndex:indexPath.row];
    
    //Hide imageView + show spinner while loading image
    [cell.articleImageView setHidden:YES];
    [cell.imageLoadingIndicator setHidden:NO];
    
    //Load image
    [[SDWebImageManager sharedManager] loadImageWithURL:article.imageUrl options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        [cell.imageLoadingIndicator setHidden:YES];
        
        //If success
        if(image){
            cell.articleImageView.image = image;
            [cell.articleImageView setHidden:NO];
            
            //Resize image to 16:9
            [NSLayoutConstraint updateAspectRatioConstraint:cell.articleImageViewAspectConstraint withMultiplier:16.0/9.0 fromView:cell.articleImageView];
        }
        //If failed
        else{
            cell.articleImageView.image = nil;
            [cell.articleImageView setHidden:YES];
            
            //Resize image to 0:0
            [NSLayoutConstraint updateAspectRatioConstraint:cell.articleImageViewAspectConstraint withMultiplier:0.0 fromView:cell.articleImageView];
        }
    }];
    
    
    cell.sectionLabel.text = article.section;
    cell.titleLabel.text = article.title;
    
    //Date
    NSString *dateStr = [article.date stringFromDatewithFormatter:@"dd/MM/yyyy"];
    if(dateStr && ![dateStr isEqualToString:@""]){
        cell.dateLabel.text = [NSString stringWithFormat:@"Le %@", dateStr];
    }
    else{
        cell.dateLabel.text = @"";
    }
    
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
    //Avoid multiple loading
    if(!_isLoadingNews){
        _isLoadingNews = YES;
        
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
            
            // End the refreshing
            if (self.refreshControl) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MMM d, HH:mm"];
                NSString *title = [NSString stringWithFormat:@"Dernière mise à jour : %@", [formatter stringFromDate:[NSDate date]]];
                NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                            forKey:NSForegroundColorAttributeName];
                NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
                self.refreshControl.attributedTitle = attributedTitle;
                
                [self.refreshControl endRefreshing];
            }
            
            _isLoadingNews = NO;
            [self.tableView reloadData];
        }];
    }
}

@end
