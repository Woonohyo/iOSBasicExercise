//
//  WNDataModel.m
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNDataModel.h"

@implementation WNDataModel
@synthesize jsonObject, sortedJsonObject;

+ (id) sharedInstance {
    static WNDataModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    
    return sharedInstance;
}

- (id) init {
    if ( self = [super init] ) {
        data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
        
        NSString *jsonString = [NSString stringWithUTF8String:data];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        isSorted = NO;
    }
    
    return self;
}

- (NSString *)PhotoTitleAt:(NSInteger)index {
    if (isSorted) {
        return [[sortedJsonObject objectAtIndex:index] valueForKey:@"title"];
    } else {
        return [[jsonObject objectAtIndex:index] valueForKey:@"title"];
    }
}

- (NSString *)PhotoFileNameAt:(NSInteger)index {
    if (isSorted) {
        return [[sortedJsonObject objectAtIndex:index] valueForKey:@"image"];
    } else {
        
        return [[jsonObject objectAtIndex:index] valueForKey:@"image"];
    }
}

- (NSString *)PhotoDateAt:(NSInteger)index {
    if (isSorted) {
        return [[sortedJsonObject objectAtIndex:index] valueForKey:@"date"];
    } else {
        return [[jsonObject objectAtIndex:index] valueForKey:@"date"];
    }
}

- (void) sortPhotoByDateAscend {
    sortedJsonObject = [jsonObject sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDate *first = [obj1 valueForKey:@"date"];
        NSDate *second = [obj2 valueForKey:@"date"];
        return [first compare:second];
    }];
}

- (void) setSorted {
    isSorted = YES;
}

- (void) setUnsorted {
    isSorted = NO;
}

@end
