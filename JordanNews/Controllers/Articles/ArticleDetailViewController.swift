//
//  ArticleDetailViewController.swift
//  JordanNews
//
//  Created by Jordan Lepretre on 04/03/2018.
//  Copyright © 2018 JDN. All rights reserved.
//

import UIKit

@objc class ArticleDetailViewController: UIViewController {
    
    public var article : ArticleModel?

    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleImageGradient: UIImageView!
    
    @IBOutlet var articleImageViewAspectConstraint: NSLayoutConstraint!
    @IBOutlet var imageLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet var articleTitleLabel: UILabel!
    @IBOutlet var articleSectionLabel: UILabel!
    @IBOutlet var articleChapoLabel: UILabel!
    @IBOutlet var articleContentLabel: UILabel!
    @IBOutlet var articleDatesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(article != nil){
            //Title
            articleTitleLabel.text = (article?.title != nil ? article?.title : "")
            
            //Section
            articleSectionLabel.text = (article?.section != nil ? article?.section : "")
            
            //Chapo
            articleChapoLabel.text = (article?.chapo != nil ? article?.chapo : "")
            
            //Content
            articleContentLabel.text = (article?.content != nil ? article?.content : "")
            
            //Date
            articleDatesLabel.text = ""
            
            let dateStr :String! = (article?.date as! NSDate).stringFromDate(withFormatter:"dd/MM/yyyy HH:mm")
            
            if(dateStr != nil && dateStr != ""){
                articleDatesLabel.text = String(format: "Le %@", dateStr)
            }

            //If edit date != date
            if(article?.editDate != article?.date){

                let editDateStr :String! = (article?.editDate as! NSDate).stringFromDate(withFormatter:"dd/MM/yyyy HH:mm")
                
                if(editDateStr != nil && editDateStr != ""){
                    articleDatesLabel.text = String(format:"%@\nMAJ le %@", articleDatesLabel.text!, editDateStr)
                }
            }

            //Hide imageView + hide gradient black + show spinner while loading image
            articleImageView.isHidden = true
            articleImageGradient.isHidden = true
            imageLoadingIndicator.isHidden = false

            //Load image
            SDWebImageManager.shared().loadImage(with: article?.imageUrl, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image, data, error, cacheType, finished, imageURL) in
                self.imageLoadingIndicator.isHidden = true
                
                //If success
                if(image != nil){
                    self.articleImageView.image = image
                    self.articleImageView.isHidden = false
                    self.articleImageGradient.isHidden = false
                    
                    //Show image
                    self.articleImageViewAspectConstraint.isActive = true
                }
                //If failed
                else{
                    self.articleImageView.image = nil
                    self.articleImageView.isHidden = true
                    self.articleImageGradient.isHidden = true
                    
                    //Hide image
                    self.articleImageViewAspectConstraint.isActive = false
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
