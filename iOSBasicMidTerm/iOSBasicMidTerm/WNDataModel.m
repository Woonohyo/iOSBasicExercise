//
//  WNDataModel.m
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNDataModel.h"

@implementation WNDataModel
@synthesize jsonObject;

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
    }
    
    return self;
}

- (NSString *)PhotoTitleAt:(NSInteger)index {
    return [[jsonObject objectAtIndex:index] valueForKey:@"title"];
}

- (NSString *)PhotoFileNameAt:(NSInteger)index {
    return [[jsonObject objectAtIndex:index] valueForKey:@"image"];
}

- (NSString *)PhotoDateAt:(NSInteger)index {
    return [[jsonObject objectAtIndex:index] valueForKey:@"date"];
}

@end
