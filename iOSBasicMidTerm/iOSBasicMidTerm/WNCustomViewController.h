//
//  WNCustomViewController.h
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 14..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNTableViewCell.h"
#import "WNDataModel.h"
#import "WNPhotoViewController.h"

@interface WNCustomViewController : UIViewController
{
    UITableView *customTableView;
    WNDataModel *dataModel;
}

@end
