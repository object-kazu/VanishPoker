//
//  KSDiviceStateContext.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/09/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSDiviceStateContext.h"

@implementation KSDiviceStateContext

-(void) detectCardTreatment:(NSMutableArray*)markerArray{
    [self.currentState searching:markerArray];
}

-(void) markerRotateByDevice{
    [self.currentState markerRotation];
}

-(void) changeState:(KSDiveState *)state{
    self.currentState = nil;
    self.currentState = state;
}

-(void) fillCardsByDivceRotate{
    [self.currentState fillCardsByDiveRotate];
}

@end
