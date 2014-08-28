//
//  WNBarGraphView.m
//  iOSBasicGraphView
//
//  Created by Wonhyo Yi on 2014. 8. 28..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNBarGraphView.h"
#define GRAPH_WIDTH 30
#define GRAPH_SPACE 50.0

@implementation WNBarGraphView
{
    int countOfGraph;
    NSMutableArray *jsonArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        countOfGraph = 0;
    }
    return self;
}

- (void)setJsonArray:(NSMutableArray *)theArray
{
    jsonArray = theArray;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[UIColor lightGrayColor] setFill];
    UIRectFill(self.bounds);
    
    UIColor *pathStrokeColor = [UIColor blueColor];
    [pathStrokeColor setStroke];
    
    for (NSArray *each in jsonArray) {
        float length = [[each valueForKey:@"value"] floatValue];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, countOfGraph*GRAPH_SPACE, 50, GRAPH_WIDTH)];
        [nameLabel setTextAlignment:NSTextAlignmentCenter];
        //[nameLabel.layer setBorderColor:[UIColor redColor].CGColor];
        //[nameLabel.layer setBorderWidth:1.0f];
        [nameLabel setText:[each valueForKey:@"title"]];
        [nameLabel setFont:[UIFont fontWithName:@"helvetica" size:9.0]];
        [self addSubview:nameLabel];
        [self drawBezierPath:length];
    }
    
    // y = 0 보조선
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor blackColor] setStroke];
    [path moveToPoint:CGPointMake(50, 0)];
    [path addLineToPoint:CGPointMake(50, 200)];
    [path setLineWidth:0.5];
    [path stroke];
}

- (void)drawBezierPath:(float)length
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(50.0, countOfGraph*GRAPH_SPACE+15);
    [path moveToPoint:startPoint];
    CGPoint nextPoint = CGPointMake(length*6+50, countOfGraph*GRAPH_SPACE+15);
    [path addLineToPoint:nextPoint];
    [path setLineWidth:GRAPH_WIDTH];
    [path stroke];
    [path fill];
    ++countOfGraph;
}

@end