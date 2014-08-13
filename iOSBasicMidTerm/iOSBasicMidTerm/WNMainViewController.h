//
//  WNMainViewController.h
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNTableViewCell.h"
#import "WNDataModel.h"
#import "WNPhotoViewController.h"

@interface WNMainViewController : UIViewController
{
    UITableView *mainTableView;
    WNDataModel *dataModel;
    NSMutableArray *jsonObject;
    NSArray *sortedJsonObject;
}

@end
