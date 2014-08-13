//
//  WNDataModel.h
//  iOSBasicMidTerm
//
//  Created by Wonhyo Yi on 2014. 8. 12..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WNDataModel : NSObject
{
    char *data;
    NSMutableArray *jsonObject;
    NSArray *sortedJsonObject;
    BOOL isSorted;
}

@property (nonatomic, strong) NSMutableArray *jsonObject;
@property (nonatomic, strong) NSArray *sortedJsonObject;

+ (id)sharedInstance;
- (NSString*)PhotoTitleAt:(NSInteger)index;
- (NSString *)PhotoFileNameAt:(NSInteger)index;
- (NSString *)PhotoDateAt:(NSInteger)index;
- (void)sortPhotoByDateAscend;

-(void)setSorted;
-(void)setUnsorted;
@end
