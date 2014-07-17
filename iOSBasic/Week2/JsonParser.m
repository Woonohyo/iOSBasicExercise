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
- (id) MyJSONSerializationFrom:(NSString*)jsonData {
    jsonData = [jsonData stringByReplacingOccurrencesOfString:@"{" withString:@""];
    jsonData = [jsonData stringByReplacingOccurrencesOfString:@"}" withString:@""];
    jsonData = [jsonData stringByReplacingOccurrencesOfString:@"“" withString:@""];
    jsonData = [jsonData stringByReplacingOccurrencesOfString:@"”" withString:@""];
    jsonData = [jsonData stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"%@", jsonData);
    
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
    
    NSLog(@"%@", resultDict);
    
    return resultDict;
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
