//
//  NumberPuzzle.m
//  iOSBasic
//
//  Created by Wonhyo Yi on 2014. 7. 24..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "NumberPuzzle.h"

@implementation NumberPuzzle
- (NSMutableArray*) CreateNewPuzzle:(int)numRows {
    NSMutableArray *cols = [[NSMutableArray alloc] initWithCapacity:numRows];
    
    for ( int i = 0; i < numRows; i++ ){
        [cols addObject:[[NSMutableArray alloc] initWithCapacity:numRows]];
    }
    
    for ( int rowIdx = 0; rowIdx < numRows; rowIdx++ ) {
        for ( int num = (rowIdx * numRows) + 1; num < (rowIdx * numRows) + (numRows + 1); num++ ) {
            if ( num == (numRows * numRows) ) {
                [[cols objectAtIndex:rowIdx] addObject:[NSNull null]];
            }
            else {
                [[cols objectAtIndex:rowIdx] addObject:[NSNumber numberWithInt:num]];
            }
        }
    }
    
    return cols;
}

- (void) printCurrentStatus:(NSMutableArray *)puzzle {
    NSUInteger numRows = [puzzle count];
    
    for ( int rowIdx = 0; rowIdx < numRows; rowIdx++ ) {
        for ( int colIdx = 0; colIdx < numRows; colIdx++ ) {
            if ([[puzzle objectAtIndex:rowIdx] objectAtIndex:colIdx] == [NSNull null]) {
                printf("  ");
            }
            else {
                printf("%3d", (int)[[[puzzle objectAtIndex:rowIdx] objectAtIndex:colIdx] intValue]);
            }
        }
        printf("\n");
    }
}

- (void) shufflePuzzle:(NSMutableArray *)puzzle {
    NSUInteger numRows = [puzzle count];
    int numRowsSquare = (int)(numRows * numRows);
    
    NSMutableArray *oneDimensionArray = [NSMutableArray arrayWithCapacity:(numRows * numRows)];
    
    for ( int rowIdx = 0; rowIdx < numRows; rowIdx++ ) {
        for ( int colIdx = 0; colIdx < numRows; colIdx++ ) {
            [oneDimensionArray addObject:[[puzzle objectAtIndex:rowIdx] objectAtIndex:colIdx]];
        }
    }
    
    for (int i = 0; i < numRowsSquare; ++i) {
        int remainingCount = numRowsSquare - i;
        int exchangeIndex = i + (arc4random() % remainingCount);
        [oneDimensionArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

- (void) movePiece:(NSMutableArray *)puzzle withDirection:(char)direction {
    
    
}



@end
