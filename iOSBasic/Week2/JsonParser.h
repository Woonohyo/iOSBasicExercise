//
//  JsonParser.h
//  iOSBasic
//
//  Created by Wonhyo Yi on 2014. 7. 17..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject
- (id) MyJSONSerializationFrom:(NSString*)jsonData;
- (NSInteger) MyJSONDistinguisher:(NSString*)jsonData;
- (NSString*) MyJSONMakerWithArray:(NSArray*)array;
- (NSString*) MyJSONMakerWithDictionary:(NSDictionary*)dictionary;
- (NSString*) MyJsonTrimmer:(NSString*)jsonSrc;

@end
