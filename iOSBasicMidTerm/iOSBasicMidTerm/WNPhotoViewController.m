//
//  WNPhotoViewController.m
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNPhotoViewController.h"

@interface WNPhotoViewController ()

@end

@implementation WNPhotoViewController

- (id)initWithIndex:(NSInteger)theIndex {
    self = [super init];
    if (self) {
        dataModel = [WNDataModel sharedInstance];
        index = theIndex;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Photo"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UILabel *photoTitleTextView = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, screenRect.size.width, 50)];
    
    [photoTitleTextView setTextAlignment:NSTextAlignmentCenter];
    [photoTitleTextView setText:[dataModel PhotoTitleAtIndex:index]];
    [photoTitleTextView setTextColor:[UIColor blackColor]];
    
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 120, 240, 240)];
    [photoImageView setImage:[UIImage imageNamed:[dataModel PhotoFileNameAtIndex:index]]];
    [photoImageView setContentMode:UIViewContentModeScaleToFill];
    
    UILabel *photoDateTextView = [[UILabel alloc] initWithFrame:CGRectMake(0, 370, screenRect.size.width, 50)];
    [photoDateTextView setTextAlignment:NSTextAlignmentCenter];
    [photoDateTextView setText:[dataModel PhotoDateAtIndex:index]];
    
    [self.view addSubview:photoDateTextView];
    [self.view addSubview:photoTitleTextView];
    [self.view addSubview:photoImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
