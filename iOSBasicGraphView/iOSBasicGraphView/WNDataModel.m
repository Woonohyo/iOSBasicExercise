//
//  WNDataModel.m
//  iOSBasicGraphView
//
//  Created by Wonhyo Yi on 2014. 8. 28..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNDataModel.h"

@implementation WNDataModel
{
    char *data;
}

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
        data = "[{\"title\":\"April\", \"value\":5},{\"title\":\"May\", \"value\":12},{\"title\":\"June\", \"value\":18},{\"title\":\"July\", \"value\":11},{\"title\":\"August\", \"value\":15},{\"title\":\"September\", \"value\":9},{\"title\":\"October\", \"value\":17},{\"title\":\"November\", \"value\":25},{\"title\":\"December\", \"value\":31}]";
        
        NSString *jsonString = [NSString stringWithUTF8String:data];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        self.jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return self;
}


@end
