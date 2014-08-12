//
//  WNDataModel.h
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNDataModel : NSObject
{
    char *data;
    NSMutableArray *jsonObject;
}

@property (nonatomic, strong) NSMutableArray *jsonObject;

+ (id)sharedInstance;

@end
