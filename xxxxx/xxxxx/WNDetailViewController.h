//
//  WNDetailViewController.h
//  xxxxx
//
//  Created by Wonhyo Yi on 2014. 8. 14..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
