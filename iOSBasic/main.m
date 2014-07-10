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
- (void) DisplayAllFilesAtPath:(NSString *) path;
- (NSArray*) WHAllFilesAtPath:(NSString *) path;
- (BOOL) isExistFilename:(NSString *)filename
                  atPath:(NSString *)path;
- (void) sortDirContentsAtPath:(NSString *)path;
- (void) isExistsMultiFilename:(NSArray *) filenames
                        atPath:(NSString *)path;
- (void) WHDisplayFileAtPath:(NSString *)path withExt:(NSString *)ext;

@end

@implementation Filemanager {
    NSFileManager *fm;
}

- (void) print {
    NSLog(@"It works!");
}

// 특정 경로를 deep-search하여 경로를 포함한 파일의 이름 및 확장자명을 출력한다.
- (void) DisplayAllFilesAtPath:(NSString *) path {
    fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    
    NSString *file;
    while ((file = [dirEnum nextObject])) {
        NSLog(@"%@", file);
    }
    
    return;
}

// 특정 경로를 deep-search하여 파일의 이름만 가진 배열을 반환한다.
- (NSArray*) WHAllFilesAtPath:(NSString*)path {
    fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    NSMutableArray *dirContents = [NSMutableArray array];
    
    for (NSString *each in dirEnum) {
        NSString *fileName = [[each lastPathComponent] stringByDeletingPathExtension];
        [dirContents addObject:fileName];
    }
    
    return dirContents;
}

// 특정 경로에 해당 이름을 가진 파일의 존재 여부를 반환한다. (확장자 제외)
- (BOOL) isExistFilename:(NSString*)filename atPath:(NSString*)path {
    NSArray *dirContents = [self WHAllFilesAtPath:path];
    for (NSString *each in dirContents) {
        if ([each isEqualToString:filename]) {
            return YES;
        }
    }
    
    return NO;
}

- (void) sortDirContentsAtPath:(NSString *)path {
    NSArray *dirContents = [self WHAllFilesAtPath:path];
    
    // comparator를 통해 정렬 구현
    dirContents = [dirContents sortedArrayUsingComparator:^(id obj1, id obj2) {
        if ([obj1 compare:obj2 options:NSCaseInsensitiveSearch] == NSOrderedDescending) {
            return (NSComparisonResult) NSOrderedDescending;
        }
        if ([obj1 compare:obj2 options:NSCaseInsensitiveSearch] == NSOrderedAscending) {
            return (NSComparisonResult) NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
    
    /*
    // selector를 통해 정렬 구현 완료
    dirContents = [dirContents sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
     */
    
    for (NSString *each in dirContents) {
        NSLog(@"%@", each);
    }
}

- (void) WHDisplayFileAtPath:(NSString *)path withExt:(NSString *)ext {
    fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSString *each in dirEnum) {
        if ( [[each pathExtension] isEqualToString:ext]) {
            [result addObject:[each lastPathComponent]];
        }
    }
    
    NSLog(@"확장자 %@을 가진 파일들의 목록을 출력합니다.", ext);
    
    for (NSString *each in result) {
        NSLog(@"%@", each);
    }
    
    return;
}

- (void) isExistsMultiFilename:(NSArray *)filenames atPath:(NSString *)path {
    NSArray *dirContents = [self WHAllFilesAtPath:path];
    
    for (NSString *eachFilename in filenames) {
        if ( [dirContents containsObject:eachFilename]) {
            NSLog(@"%@라는 이름을 가진 파일은 존재합니다.", eachFilename);
        }
        else  {
            NSLog(@"%@라는 이름을 가진 파일은 존재하지 않습니다.", eachFilename);
        }
    }
}

@end


int main(int argc, const char * argv[])
{
    NSString *path = @"/Users/Woonohyo/Documents/NEXT/5th/iOSBasic";
    NSString *fileName = @"main";
    NSString *ext = @"m";
    NSArray *multiFileName = [NSArray arrayWithObjects:@"test", @"main", @"dummy",nil];
    Filemanager *fm = [[Filemanager alloc] init];
    
    /*
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
     */
    
    // 플러스미션 #1. 파일명 순서대로 정렬하기
    //[fm sortDirContentsAtPath:path];
    
    // 플러스미션 #2. 파일명이 여러개일때 해당 경로에 각각에 대한 존재여부 출력하기
    [fm isExistsMultiFilename:multiFileName atPath:path];
    
    
    // 플러스미션 #3. 특정 확장자명을 가진 파일을 찾고, 있을 경우 해당 파일 목록 출력하기
    //[fm WHDisplayFileAtPath:path withExt:ext];
    
    
    return 0;
}
