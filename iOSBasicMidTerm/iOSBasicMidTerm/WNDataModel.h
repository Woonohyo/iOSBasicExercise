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
    NSMutableArray *sortedJsonObject;
    BOOL isSorted;
}

@property (nonatomic, strong) NSMutableArray *jsonObject;
@property (nonatomic, strong) NSArray *sortedJsonObject;

+ (id)sharedInstance;
- (NSString*)PhotoTitleAtIndex:(NSInteger)index;
- (NSString *)PhotoFileNameAtIndex:(NSInteger)index;
- (NSString *)PhotoDateAtIndex:(NSInteger)index;
- (void)sortPhotoByDateAscend;

- (NSInteger) count;
-(void)setSorted;
-(void)setUnsorted;
-(void)removeObjectAtIndex:(NSInteger)index;
@end
