//
//  WNMainViewController.m
//  iOSBasicScrollView
//
//  Created by Wonhyo Yi on 2014. 8. 7..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNMainViewController.h"

@interface WNMainViewController () <UIScrollViewDelegate>

@end

@implementation WNMainViewController

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
    
    imageCacheArray = [NSMutableArray array];
    imageArray = [NSMutableArray array];
    NSString *imageName;
    NSString *imagePath;
    for (int i = 1; i < 4; ++i) {
        imageName = [NSString stringWithFormat:@"%02d.jpg", i];
        imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]];
        [imageView setFrame:CGRectMake(0, 320*(i-1), 320, 320)];
        [imageArray addObject:imageView];
        [imageView setTag:(i - 1)];
        [imageView setContentMode:UIViewContentModeScaleToFill];
    }
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    [mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, (self.view.frame.size.width * 22) + 20)];
    [mainScrollView setDelegate:self];
    [mainScrollView setScrollEnabled:YES];
    [mainScrollView setAlwaysBounceVertical:YES];
    [mainScrollView.layer setBorderColor:[UIColor redColor].CGColor];
    [mainScrollView.layer setBorderWidth:2.0];
    [mainScrollView setBackgroundColor:[UIColor clearColor]];
    
    [mainScrollView addSubview:[imageArray objectAtIndex:0]];
    [mainScrollView addSubview:[imageArray objectAtIndex:1]];
    [mainScrollView addSubview:[imageArray objectAtIndex:2]];
    
    [self.view addSubview:mainScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNextImages:(int)currentPage {
    NSLog(@"currentpage: %d", currentPage);
    NSString *imageName = [NSString stringWithFormat:@"%02d.jpg", currentPage+2];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath]];
    NSLog(@"%@", imageView);
    [imageView setFrame:CGRectMake(0, 320*(currentPage+1), 320, 320)];
    [imageArray addObject:imageView];
    NSLog(@"%@", imageArray);
    [imageView setTag:currentPage+1];
    [imageView setContentMode:UIViewContentModeScaleToFill];
}

- (void)loadPreviousImages:(int)currentPage {
    
}

- (void) deleteNeedlessImages:(int)index {
    NSLog(@"deleting %d",index);
    [imageArray removeObjectAtIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int currentPage = (scrollView.contentOffset.y / 320);
    
    if ( [scrollView viewWithTag:(currentPage + 1)]) {
        
    }
    else {
        [self loadNextImages:currentPage];
        [mainScrollView addSubview:[imageArray objectAtIndex:(currentPage+1)]];
    }
    
    if ( [scrollView viewWithTag:(currentPage - 1)] || currentPage == 0) {
        
    }
    else{
        [self loadPreviousImages:currentPage];
        [mainScrollView addSubview:[imageArray objectAtIndex:currentPage-1]];
    }
    
    for ( int i = 0; i < currentPage; ++i) {
        if ( (i < (currentPage - 2) || i > (currentPage + 1)) && [mainScrollView viewWithTag:(i+1)] ) {
            [self deleteNeedlessImages:(i+1)];
            [[mainScrollView viewWithTag:(i+1)] removeFromSuperview];
        }
    }
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
