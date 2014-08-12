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
    
    [self.view addSubview:mainTableView];
}

- (void) receiveNoti:(NSNotification *) noti {
    if ([[noti name] isEqualToString:@"DataModelInitialized"]) {
        NSLog(@"Data Model Init Complete");
        [mainTableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"tableViewCell";
    WNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        cell = [[WNTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    [cell.textLabel setText:[[jsonObject objectAtIndex:[indexPath row]] valueForKey:@"title"]];
    [cell.detailTextLabel setText:[[jsonObject objectAtIndex:[indexPath row]] valueForKey:@"date"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WNPhotoViewController *photoViewController = [[WNPhotoViewController alloc] initWithIndex:[indexPath row]];
    
    [self.navigationController pushViewController:photoViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
