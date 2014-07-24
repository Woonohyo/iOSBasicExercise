//
//  NumberPuzzle.h
//  iOSBasic
//
//  Created by Wonhyo Yi on 2014. 7. 24..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberPuzzle : NSObject
- (NSMutableArray*) CreateNewPuzzle:(int)numRows;
- (void) printCurrentStatus:(NSMutableArray *)puzzle;
- (void) movePiece:(NSMutableArray*)puzzle withDirection:(char)direction;
- (void) shufflePuzzle:(NSMutableArray *)puzzle;
@end
