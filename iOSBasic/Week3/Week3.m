//
//  Week3.m
//  iOSBasic
//
//  Created by Wonhyo Yi on 2014. 7. 24..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberPuzzle.h"

int main(int argc, const char * argv[])
{
    NumberPuzzle *numberPuzzle = [[NumberPuzzle alloc] init];
    NSMutableArray *createdPuzzle = nil;
    int numRows = 15;
    
    while ( numRows < 2 || numRows > 10 ) {
        printf("Size of Puzzle?(2 ~ 10) ");
        scanf("%d", &numRows);
    }
    
    createdPuzzle = [numberPuzzle CreateNewPuzzle:numRows];
    
    printf("///New Puzzle Created///\n");
    [numberPuzzle printCurrentStatus:createdPuzzle];
    printf("///Shuffling...///\n");
    [numberPuzzle shufflePuzzle:createdPuzzle];
    [numberPuzzle printCurrentStatus:createdPuzzle];
    
    char userInput = 'a';
    
    while ( userInput != 'q') {
        getchar();
        printf("use 'WASD' to move you puzzle piece\n");
        scanf("%c", &userInput);
        [numberPuzzle movePiece:createdPuzzle withDirection:userInput];
        
        [numberPuzzle printCurrentStatus:createdPuzzle];
    }
    
    [numberPuzzle release];
    
    printf("Bye Bye~\n");
    
    return 0;
}
