//
//  KSButtonTop.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/09/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSButtonTop.h"
#import "KSMasu.h"
#import "KSCardManager.h"


@implementation KSButtonTop

static KSDiveState* _sharedInstance = nil;

+(KSDiveState*) sharedState{
    if (!_sharedInstance) {
        _sharedInstance = [KSButtonTop new];
    }
    
    return _sharedInstance;
}


-(void) searching:(NSMutableArray *)markerArray{
    MasuPoint    emptyMasuPoint;
    MasuPoint    movingCardPoint;
    
//    NSLog(@"button top");
    
    for ( int x = MASU_X_MAX; x >= 0; x-- ) {
        for ( int y = 0; y <= self.masuMax_y; y++ ) {
            emptyMasuPoint.x = x;
            emptyMasuPoint.y = y;
            //            NSLog(@"searching: %d,%d", emptyMasuPoint.x, emptyMasuPoint.y);
            
            BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:emptyMasuPoint];
            if ( isEmptyMasu ) {            //空きマスが見つかったら
                movingCardPoint = [self selectMoveCardUnder:emptyMasuPoint];
                
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
    
    //    NSLog(@"button top");
    
    for ( int x = MASU_X_MAX; x >= 0; x-- ) {
        for ( int y = 0; y <= self.masuMax_y; y++ ) {
            emptyMasuPoint.x = x;
            emptyMasuPoint.y = y;
//            NSLog(@"searching: %d,%d", emptyMasuPoint.x, emptyMasuPoint.y);

            
            BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:emptyMasuPoint];
            if ( isEmptyMasu ) {            //空きマスが見つかったら
                movingCardPoint = [self selectMoveCardUnder:emptyMasuPoint];
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
    int angle = 180;
    [super markerRotateBy:angle];
    
}


@end
