//
//  WNMainViewController.h
//  iOSBasicNotification
//
//  Created by Wonhyo Yi on 2014. 7. 31..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNRSPModel.h"

@interface WNMainViewController : UIViewController {
    UIImageView *rspImageView;
}
@property (strong, nonatomic) WNRSPModel *rspModel;
@property NSInteger rspValue;

@end
