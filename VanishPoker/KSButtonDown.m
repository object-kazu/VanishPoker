//
//  KSButtonDown.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/09/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSButtonDown.h"
#import "KSMasu.h"
#import "KSCardManager.h"


@implementation KSButtonDown

static KSDiveState* _sharedInstance = nil;

+(KSDiveState*) sharedState{
    if (!_sharedInstance) {
        _sharedInstance = [KSButtonDown new];
    }
    
    return _sharedInstance;
}


-(void) searching:(NSMutableArray*)markerArray{
    MasuPoint    emptyMasuPoint;
    MasuPoint    movingCardPoint;
    
    NSLog(@"button down");
    
    for ( int x = 0; x <= MASU_X_MAX; x++ ) {
        for ( int y = super.masuMax_y; y >= 0; y-- ) {
            emptyMasuPoint.x = x;
            emptyMasuPoint.y = y;
            
            /*
             空きマスがある（em = YES）で
             movingFlag = YES　　とし、
             つぎに空きマスがない（em = NO）のときにCard moving!
             */
            BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:emptyMasuPoint];
            if ( isEmptyMasu ) {            //空きマスが見つかったら
                movingCardPoint = [self selectMoveCardAbove:emptyMasuPoint];
                
                if ( movingCardPoint.y == OUT_OF_MASU ) {
                    [super hiddenCardMoveTo:emptyMasuPoint markerArray:markerArray];
                } else {
                    [super fillCardFrom:movingCardPoint toEmptyMasu:emptyMasuPoint];
                }
                
            }
            
        }
    }

}

-(void)fillCardsByDiveRotate{
    MasuPoint    emptyMasuPoint;
    MasuPoint    movingCardPoint;
        
    for ( int x = 0; x <= MASU_X_MAX; x++ ) {
        for ( int y = super.masuMax_y; y >= 0; y-- ) {
            emptyMasuPoint.x = x;
            emptyMasuPoint.y = y;
            
            /*
             空きマスがある（em = YES）で
             movingFlag = YES　　とし、
             つぎに空きマスがない（em = NO）のときにCard moving!
             */
            
//            NSLog(@"searching: %d,%d", emptyMasuPoint.x, emptyMasuPoint.y);

            BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:emptyMasuPoint];
            if ( isEmptyMasu ) {            //空きマスが見つかったら
                movingCardPoint = [self selectMoveCardAbove:emptyMasuPoint];
                if ( movingCardPoint.y == OUT_OF_MASU ) {
//                    [super hiddenCardMoveTo:emptyMasuPoint markerArray:markerArray];
                } else {
                    [super fillCardFrom:movingCardPoint toEmptyMasu:emptyMasuPoint];
                }


                
            }
            
        }
    }

}

-(void) markerRotation{
    // 回転させるためのアフィン変形を作成する
    int angle = 0;
    [super markerRotateBy:angle];
    
}


@end
