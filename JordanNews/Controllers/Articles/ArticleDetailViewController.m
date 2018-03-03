//
//  ArticleDetailViewController.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSDate+Utilities.h"

@interface ArticleDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *articleImageView;
@property (strong, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *articleChapoLabel;
@property (strong, nonatomic) IBOutlet UILabel *articleContentLabel;
@property (strong, nonatomic) IBOutlet UILabel *articleDatesLabel;

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.article){
        //Title
        _articleTitleLabel.text = (self.article.title ? self.article.title : @"");
        
        //Chapo
        _articleChapoLabel.text = (self.article.chapo ? self.article.chapo : @"");
        
        //Content
        _articleContentLabel.text = (self.article.content ? self.article.content : @"");
        
        //Date
        _articleDatesLabel.text = @"";
        
        NSString *dateStr = [self.article.date stringFromDatewithFormatter:@"dd/MM/yyyy HH:mm"];
        if(dateStr && ![dateStr isEqualToString:@""]){
            _articleDatesLabel.text = [NSString stringWithFormat:@"Le %@", dateStr];
        }
        
        //If edit date != date
        if(![self.article.editDate isEqualToDate:self.article.date]){
            NSString *editDateStr = [self.article.editDate stringFromDatewithFormatter:@"dd/MM/yyyy HH:mm"];
            if(editDateStr && ![editDateStr isEqualToString:@""]){
                _articleDatesLabel.text = [NSString stringWithFormat:@"%@\nMAJ le %@", _articleDatesLabel.text, editDateStr];
            }
        }
        
#warning TODO display spinner while loading + hide gradient black
#warning TODO resize if failed
        [_articleImageView sd_setImageWithURL:self.article.imageUrl];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
