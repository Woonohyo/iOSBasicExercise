//
//  WNDataModel.h
//  iOSBasicGraphView
//
//  Created by Wonhyo Yi on 2014. 8. 28..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNDataModel : NSObject
+ (id) sharedInstance;

@property (strong, nonatomic) NSMutableArray *jsonObject;
@end
