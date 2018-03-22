//
//  KSDiveState.h
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/09/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSMasu.h"
#import "KSMarkManager.h"

@interface KSDiveState : NSObject

@property (nonatomic) NSInteger  masuMax_y;
@property (nonatomic,retain) KSMarkManager* markManager;


+(KSDiveState*) sharedState;

-(void) searching:(NSMutableArray*) markerArray;
-(void) markerRotation;
-(void) markerRotateBy:(int) angle;

-(void) fillCardsByDiveRotate;


- (void)fillCardFrom:(MasuPoint)fillcard toEmptyMasu:(MasuPoint)empty;
- (void)hiddenCardMoveTo:(MasuPoint)masu markerArray:(NSMutableArray*)markerArray ;

- (MasuPoint)selectMoveCardAbove:(MasuPoint)masu;
- (MasuPoint)selectMoveCardUnder:(MasuPoint)masu;
- (MasuPoint)selectMoveCardLeft:(MasuPoint)masu;
- (MasuPoint)selectMoveCardRight:(MasuPoint)masu;

@end
