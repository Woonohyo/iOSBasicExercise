//
//  WNCustomViewController.m
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 14..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNCustomViewController.h"
#define ROW_HEIGHT 80

@interface WNCustomViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation WNCustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataModel = [WNDataModel sharedInstance];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeCustomView)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height) style:UITableViewStylePlain];
    [customTableView registerClass:[WNTableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    [customTableView setDelegate:self];
    [customTableView setDataSource:self];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"알림" message:@"정렬한 후에도 열어보세요." delegate:self cancelButtonTitle:@"어 그래" otherButtonTitles:nil, nil];
    [alertView show];
    
    [self.view addSubview:customTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeCustomView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WNPhotoViewController *photoViewController = [[WNPhotoViewController alloc] initWithIndex:[indexPath row]];
    
    [self.navigationController pushViewController:photoViewController animated:YES];
}

# pragma mark -
# pragma mark UITableView Setting

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [customTableView cellForRowAtIndexPath:indexPath];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( cell == nil ) {
        cell = [[WNTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dataModel PhotoFileNameAtIndex:[indexPath row]]]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, ROW_HEIGHT)];
    [cell.contentView addSubview:backgroundView];
    [cell setContentMode:UIViewContentModeCenter];
    
    [cell.textLabel setText:[dataModel PhotoTitleAtIndex:[indexPath row]]];
    [cell.textLabel setTextAlignment:NSTextAlignmentRight];
    [cell.contentView bringSubviewToFront:cell.textLabel];
    
    return cell;
}

- (void) sortTableView {
    [dataModel sortPhotoByDateAscend];
}


@end
