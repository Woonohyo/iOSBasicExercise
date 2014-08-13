//
//  WNMainViewController.m
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNMainViewController.h"

@interface WNMainViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WNMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:nil object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Album"];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortTableView)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    dataModel = [WNDataModel sharedInstance];
    if ( dataModel ) {
        jsonObject = [dataModel jsonObject];
        if (jsonObject) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataModelInitialized" object:self];
        }
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height) style:UITableViewStylePlain];
    [mainTableView registerClass:[WNTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [mainTableView setAllowsMultipleSelectionDuringEditing:NO];
    
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
        
    }
    else if ([[noti name] isEqualToString:@"shake"]) {
        [dataModel setUnsorted];
        
    }
    [mainTableView reloadData];
}

# pragma mark -
# pragma mark UITableView Setting

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataModel.jsonObject count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"tableViewCell";
    WNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        cell = [[WNTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

        [cell.textLabel setText:[dataModel PhotoTitleAt:[indexPath row]]];
        [cell.detailTextLabel setText:[dataModel PhotoDateAt:[indexPath row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WNPhotoViewController *photoViewController = [[WNPhotoViewController alloc] initWithIndex:[indexPath row]];
    
    [self.navigationController pushViewController:photoViewController animated:YES];
}

- (void) sortTableView {
    [dataModel sortPhotoByDateAscend];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SortingDataModelCompletes" object:self];
}

# pragma mark UITableView - Swipe to delete
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Editing!");
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
