//
//  WNPhotoViewController.h
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNDataModel.h"

@interface WNPhotoViewController : UIViewController{
    WNDataModel *dataModel;
    NSInteger index;
}

- (id)initWithIndex:(NSInteger)theIndex;

@end
