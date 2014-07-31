//
//  WNRSPModel.m
//  iOSBasicNotification
//
//  Created by Wonhyo Yi on 2014. 7. 31..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNRSPModel.h"

@implementation WNRSPModel
- (void) randomize {
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    int randomValue = arc4random() % 3;
    NSLog(@"%d", randomValue);
    
    NSNotification *RSPNoti = [NSNotification notificationWithName:@"RSPNoti" object:[NSNumber numberWithInt:randomValue]];
    [notiCenter postNotification:RSPNoti];
}
@end
