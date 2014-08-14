//
//  WNMainViewController.m
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNMainViewController.h"

@interface WNMainViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@end

@implementation WNMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:nil object:dataModel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Album"];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortTableView)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    dataModel = [WNDataModel sharedInstance];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height) style:UITableViewStylePlain];
    //[mainTableView registerClass:[WNTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    
    [self.view addSubview:mainTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark -
# pragma mark NSNotificationCenter

- (void) receiveNoti:(NSNotification *) noti {
    if ([[noti name] isEqualToString:@"DataModelInitialized"]) {
    }
    else if ([[noti name] isEqualToString:@"SortingDataModelCompletes"]) {
        sortedJsonObject = [dataModel sortedJsonObject];
        [dataModel setSorted];
        [mainTableView reloadData];
        
    }
    else if ([[noti name] isEqualToString:@"shake"]) {
        [dataModel setUnsorted];
        [mainTableView reloadData];
    }
    else if ([[noti name] isEqualToString:@"ObjectDeleted"]) {
        [mainTableView reloadData];
    }
}

# pragma mark -
# pragma mark UITableView Setting

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    [cell.textLabel setText:[dataModel PhotoTitleAtIndex:[indexPath row]]];
    [cell.detailTextLabel setText:[dataModel PhotoDateAtIndex:[indexPath row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WNPhotoViewController *photoViewController = [[WNPhotoViewController alloc] initWithIndex:[indexPath row]];
    
    [self.navigationController pushViewController:photoViewController animated:YES];
}

- (void) sortTableView {
    [dataModel sortPhotoByDateAscend];
}


# pragma mark UITableView - Swipe to delete
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [dataModel removeObjectAtIndex:[indexPath row]];
    }
}


#pragma mark -
#pragma mark Shaking Gesture

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
    }
}

@end
