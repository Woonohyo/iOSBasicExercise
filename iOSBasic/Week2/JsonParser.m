//
//  JsonParser.m
//  iOSBasic
//
//  Created by Wonhyo Yi on 2014. 7. 17..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "JsonParser.h"

//NSString* sampleJson = @"{“id”:007, “name”:“james”,“weapons”:“gun”}";

@implementation JsonParser

// jsonData를 입력받아서, 공백 제거 및 큰따옴표를 '\"' 로 치환.
- (NSString *) MyJsonTrimmer:(NSString *)jsonSrc {
    jsonSrc = [jsonSrc stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonSrc = [jsonSrc stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    jsonSrc = [jsonSrc stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
    
    return jsonSrc;
}


 /*
 jsonData를 입력받아서 첫번째 문자 확인을 통해,
 Dictionary :    0
 Array      :    1
 Object     :    2
 Colon      :    3
 Comma      :    4
 Other      :   -1
 를 반환한다.
 */
- (NSInteger) MyJSONDistinguisher:(NSString *)jsonData {
    if ([jsonData characterAtIndex:0] == '{') {
        return 0;
    }
    else if ([jsonData characterAtIndex:0] == '[') {
        return 1;
    }
    else if ([jsonData characterAtIndex:0] == '\"') {
        return 2;
    }
    else if ([jsonData characterAtIndex:0] == ':') {
        return 3;
    }
    else if ([jsonData characterAtIndex:0] == ',') {
        return 4;
    }
    else {
        return -1;
    }
}

//NSString* sampleJson = @"{“id”:007, “name”:“james”,“weapons”:“gun”}";
- (id) MyJSONSerializationFrom:(NSString*)jsonData {
    NSMutableString *jsonString = [NSMutableString stringWithString:[self MyJsonTrimmer:jsonData]] ;
    
    
    if ( [self MyJSONDistinguisher:jsonData] == 0) {
        [jsonString deleteCharactersInRange: NSMakeRange(0, 1)];
        NSLog(@"%@", jsonString);
    }
    
    
    /*
     NSArray *commaArray = [jsonData componentsSeparatedByString:@","];
     NSMutableArray * keyArray = [NSMutableArray array];
     NSMutableArray * valueArray = [NSMutableArray array];
     
     for ( NSString* each in commaArray ) {
     //NSLog(@"%@", each);
     [keyArray addObject:[each componentsSeparatedByString:@":"][0]];
     [valueArray addObject:[each componentsSeparatedByString:@":"][1]];
     }
     
     NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
     for ( int i = 0; i < [keyArray count]; i++) {
     [resultDict setObject:valueArray[i] forKey:keyArray[i]];
     }
     
     return resultDict;
     */
    return NULL;
}

- (NSString*) MyJSONMakerWithArray:(NSArray *)array {
    NSString *jsonString = @"[";
    NSInteger numOfArr = [array count];
    int commaCount = 1;
    
    for ( NSString *each in array ) {
        jsonString = [jsonString stringByAppendingString:each];
        if ( commaCount < numOfArr )
            jsonString = [jsonString stringByAppendingString:@","];
        ++commaCount;
    }
    
    jsonString = [jsonString stringByAppendingString:@"]"];
    
    return jsonString;
}

//NSString* sampleJson = @"{“id”:007, “name”:“james”,“weapons”:“gun”}";
- (NSString*) MyJSONMakerWithDictionary:(NSDictionary *)dictionary {
    NSEnumerator *keyEnum = [dictionary keyEnumerator];
    NSString *key;
    NSString *jsonString = @"{";
    int commaCount = 1;
    NSInteger numOfDict = [dictionary count];
    
    while ( key = [keyEnum nextObject] ) {
        NSLog(@"Value: %@", [dictionary valueForKey:key]);
        NSString *keyValueString = [NSString stringWithFormat:@"“%@”:“%@”", key, [dictionary valueForKey:key]];
        jsonString = [jsonString stringByAppendingString:keyValueString];
        
        if ( commaCount < numOfDict )
            jsonString = [jsonString stringByAppendingString:@","];
        ++commaCount;
    }
    
    jsonString = [jsonString stringByAppendingString:@"}"];
    
    return jsonString;
}

@end
