//
//  KSDiviceStateContext.h
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/09/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSDiveState.h"


@interface KSDiviceStateContext : NSObject

@property (nonatomic,retain) KSDiveState* currentState;

-(void) detectCardTreatment:(NSMutableArray*)markerArray;
-(void) markerRotateByDevice;
-(void) changeState:(KSDiveState*) state;
-(void) fillCardsByDivceRotate;

@end
