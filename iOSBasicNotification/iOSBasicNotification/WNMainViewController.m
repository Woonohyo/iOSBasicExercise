//
//  WNMainViewController.m
//  iOSBasicNotification
//
//  Created by Wonhyo Yi on 2014. 7. 31..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNMainViewController.h"

@interface WNMainViewController ()

@end

@implementation WNMainViewController
@synthesize rspModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:nil object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Woonohyo's RSP"];
    
    [self addObserver:self forKeyPath:@"rspValue" options:NSKeyValueObservingOptionNew context:nil];
    
    rspImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    rspImageView.center = [self.view center];
    [rspImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:rspImageView];
    
    rspModel = [[WNRSPModel alloc] init];
    [rspModel randomize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) receiveNotification:(NSNotification *)noti {
    if ( [[noti name] isEqualToString:@"RSPNoti"] )
    {
        self.rspValue = [[noti object] integerValue];
        [self changeRSPImage];
    }
}

- (void) changeRSPImage {
    switch (self.rspValue) {
        case 0:
            [rspImageView setImage:[UIImage imageNamed:@"rock.png"]];
            break;
        case 1:
            [rspImageView setImage:[UIImage imageNamed:@"scissors.png"]];
            break;
        case 2:
            [rspImageView setImage:[UIImage imageNamed:@"paper.png"]];
            break;
        default:
            break;
    }
}

- (void) generateRSP {
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        [rspModel randomize];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ( [keyPath isEqualToString:@"rspValue"] ) {
        NSLog(@"KVO: rspValue Changed");
        NSLog(@"%@", [change valueForKey:@"new"]);
        [self changeRSPImage];
    }
}

@end
