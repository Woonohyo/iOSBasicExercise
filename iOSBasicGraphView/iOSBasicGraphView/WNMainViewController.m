//
//  WNMainViewController.m
//  iOSBasicGraphView
//
//  Created by Wonhyo Yi on 2014. 8. 28..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNMainViewController.h"

@interface WNMainViewController ()

@end

@implementation WNMainViewController
{
    WNDataModel *dataModel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"MainView"];
    dataModel = [WNDataModel sharedInstance];
    WNBarGraphView *graphView = [[WNBarGraphView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [graphView setJsonArray:[dataModel jsonObject]];
    [graphView setCenter:[self.view center]];
    [self.view addSubview:graphView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end