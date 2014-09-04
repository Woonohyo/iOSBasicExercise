//
//  WNMainViewController.m
//  iOSBasicGCD
//
//  Created by Wonhyo Yi on 2014. 9. 4..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNMainViewController.h"

@interface WNMainViewController () <UIAlertViewDelegate>
{
    NSArray *jsonArray;
    NSDictionary *countDict;
    NSCountedSet *wordSet;
    NSArray *values;
    int count;
}

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
    count = 0;
    
    [super viewDidLoad];
    countDict = [NSMutableDictionary dictionary];
    wordSet = [[NSCountedSet alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bookfile" ofType:@"txt"];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *jsonURL = [NSURL URLWithString:@"http://125.209.194.123/wordlist.php"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
    jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];

    CFTimeInterval startTime = CACurrentMediaTime();
    NSLog(@"%f", startTime);
    for ( id each in jsonArray) {
//        dispatch_async(dispatch_get_main_queue(), ^{
        [countDict setValue:[NSNumber numberWithInteger:[self countOfSubstring:each atContents:contents]] forKey:each];
//        });
        
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    values = [countDict keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare: obj2];
    }];
    NSLog(@"%f", CACurrentMediaTime());
    CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
    NSLog(@"%f", elapsedTime);
    
    NSString *searchResultStr = [NSString stringWithFormat:@"[최대: %@ %@회]\n[최소: %@ %@회]\n소요 시간: %f",
                                 [values objectAtIndex:[values count] - 1],
                                 [countDict valueForKey:[values objectAtIndex:[values count] - 1]],
                                 [values objectAtIndex:0],
                                 [countDict valueForKey:[values objectAtIndex:0]],
                                 elapsedTime];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Search Result"
                                                        message:searchResultStr
                                                       delegate:self
                                              cancelButtonTitle:@"닫기"
                                              otherButtonTitles:nil, nil];
    [alertView show];
//    });
    
}

/*
 dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 dispatch_queue_t mainQueue = dispatch_get_main_queue();
 
 dispatch_async(globalQueue, ^{
 CFTimeInterval startTime = CACurrentMediaTime();
 for ( id each in jsonArray) {
 dispatch_async(globalQueue, ^{
 [countDict setValue:[NSNumber numberWithInteger:[self countOfSubstring:each atContents:contents]] forKey:each];
 });
 }
 
 dispatch_async(globalQueue, ^{
 values = [countDict keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
 return [obj1 compare: obj2];
 }];
 });
 
 dispatch_async(mainQueue, ^{
 
 CFTimeInterval elapsedTime = CACurrentMediaTime() - startTime;
 NSLog(@"%f", elapsedTime);
 
 NSString *searchResultStr = [NSString stringWithFormat:@"[최대: %@ %@회]\n[최소: %@ %@회]\n소요 시간: %f",
 [values objectAtIndex:[values count] - 1],
 [countDict valueForKey:[values objectAtIndex:[values count] - 1]],
 [values objectAtIndex:0],
 [countDict valueForKey:[values objectAtIndex:0]],
 elapsedTime];
 
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Search Result"
 message:searchResultStr
 delegate:self
 cancelButtonTitle:@"닫기"
 otherButtonTitles:nil, nil];
 [alertView show];
 
 
 });
 });
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:substring options:0 error:nil];
    return [regex numberOfMatchesInString:contents options:0 range:NSMakeRange(0, [contents length])];
}

/*
 
 - (void) parseContentsByWord:(NSString*)contents {
 [contents enumerateSubstringsInRange:NSMakeRange(0, [contents length])
 options:NSStringEnumerationByWords | NSStringEnumerationLocalized
 usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
 
 // This block is called once for each word in the string.
 [wordSet addObject:substring];
 }];
 }
 
 - (void) substring:(NSString*)contents {
 NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"과학+" options:0 error:nil];
 NSLog(@"%d", [regex numberOfMatchesInString:contents options:0 range:NSMakeRange(0, [contents length])]);
 }
 */

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
