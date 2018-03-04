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
#import "NSLayoutConstraint+Utilities.h"

@interface ArticleDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *articleImageView;
@property (strong, nonatomic) IBOutlet UIImageView *articleImageGradient;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *articleImageViewAspectConstraint;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingIndicator;

@property (strong, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *articleSectionLabel;
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
        
        //Section
        _articleSectionLabel.text = (self.article.section ? self.article.section : @"");
        
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
        
        //Hide imageView + hide gradient black + show spinner while loading image
        [self.articleImageView setHidden:YES];
        [self.articleImageGradient setHidden:YES];
        [self.imageLoadingIndicator setHidden:NO];
        
        //Load image
        [[SDWebImageManager sharedManager] loadImageWithURL:self.article.imageUrl options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            [self.imageLoadingIndicator setHidden:YES];
            
            //If success
            if(image){
                self.articleImageView.image = image;
                [self.articleImageView setHidden:NO];
                [self.articleImageGradient setHidden:NO];
                
                //Resize image to 16:9
//                [NSLayoutConstraint updateAspectRatioConstraint:self.articleImageViewAspectConstraint withMultiplier:16.0/9.0 fromView:self.articleImageView];
                [self.articleImageViewAspectConstraint setActive:YES];
            }
            //If failed
            else{
                self.articleImageView.image = nil;
                [self.articleImageView setHidden:YES];
                [self.articleImageGradient setHidden:YES];
                
                //Resize image to 0:0
//                [NSLayoutConstraint updateAspectRatioConstraint:self.articleImageViewAspectConstraint withMultiplier:0.0 fromView:self.articleImageView];
                [self.articleImageViewAspectConstraint setActive:NO];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
