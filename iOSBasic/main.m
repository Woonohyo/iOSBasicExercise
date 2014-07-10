//
//  main.m
//  iOSBasic
//
//  Created by Wonhyo Yi on 2014. 7. 10..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filemanager : NSObject
- (void) print;
- (void) WHDisplayAllFilesAtPath:(NSString *) path;
- (NSArray*) WHAllFilesAtPath:(NSString*) path;
- (BOOL) isExistFilename:(NSString*)filename
                  atPath:(NSString*)path;

@end

@implementation Filemanager

- (void) print {
    NSLog(@"It works!");
}

- (void) WHDisplayAllFilesAtPath:(NSString *) path {
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    
    NSString *file;
    while ((file = [dirEnum nextObject])) {
        NSLog(@"%@", file);
    }
    
    return;
}

- (NSArray*) WHAllFilesAtPath:(NSString*)path {
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    NSMutableArray *dirContetns = [NSMutableArray array];
    
    for (NSString *each in dirEnum) {
        NSString *fileName = [[each lastPathComponent] stringByDeletingPathExtension];
        [dirContetns addObject:fileName];
    }
    
    return dirContetns;
}

- (BOOL) isExistFilename:(NSString*)filename atPath:(NSString*)path {
    NSArray *dirContents = [self WHAllFilesAtPath:path];
    for (NSString *each in dirContents) {
        if ([each isEqualToString:filename]) {
            return YES;
        }
    }
    
    return NO;
}

@end


int main(int argc, const char * argv[])
{
    NSString *path = @"/Users/Woonohyo/Documents/NEXT/5th/iOSBasic";
    NSString *fileName = @"main";
    Filemanager *fm = [[Filemanager alloc] init];
    
    // #1. 특정 경로 안의 모든 파일 출력.
    [fm WHDisplayAllFilesAtPath:path];
    
    // #2. 특정 경로 안의 해당 파일 이름을 가진 파일이 존재하는지 판별.
    if([fm isExistFilename:fileName atPath:path])
    {
        NSLog(@"File Exists!");
    }
    else
    {
        NSLog(@"File doesn't exist!");
    }
    
    // 플러스미션 #1. 파일명 순서대로 정렬하기
    return 0;
}
