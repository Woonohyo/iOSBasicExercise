//
//  WNAppDelegate.h
//  iOSBasicNotification
//
//  Created by Wonhyo Yi on 2014. 7. 31..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNMainViewController.h"

@interface WNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) UIViewController *mainViewController;
@end
