//
//  ArticleDetailViewController.m
//  JordanNews
//
//  Created by Jordan Lepretre on 02/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ArticleDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *articleImageView;
@property (strong, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *articleContentLabel;

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.article){
        _articleTitleLabel.text = self.article.title;
        _articleContentLabel.text = self.article.content;
        
#warning TODO display spinner while loading
#warning TODO resize if failed
        [_articleImageView sd_setImageWithURL:self.article.imageUrl];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
