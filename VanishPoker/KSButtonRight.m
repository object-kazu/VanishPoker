//
//  KSButtonRight.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/09/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSButtonRight.h"
#import "KSMasu.h"
#import "KSCardManager.h"


@implementation KSButtonRight

static KSDiveState* _sharedInstance = nil;

+(KSDiveState*) sharedState{
    if (!_sharedInstance) {
        _sharedInstance = [KSButtonRight new];
    }
    
    return _sharedInstance;
}


-(void) searching:(NSMutableArray *)markerArray{
    MasuPoint    emptyMasuPoint;
    MasuPoint    movingCardPoint;
    
    
    NSLog(@"button right");

    for ( int y = self.masuMax_y; y >= 0; y-- ) {
        for ( int x = MASU_X_MAX; x >= 0; x-- ) {
            
            emptyMasuPoint.x = x;
            emptyMasuPoint.y = y;
            //            NSLog(@"searching: %d,%d", emptyMasuPoint.x, emptyMasuPoint.y);
            
            BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:emptyMasuPoint];
            if ( isEmptyMasu ) {            //空きマスが見つかったら
                movingCardPoint = [self selectMoveCardLeft:emptyMasuPoint];
                if ( movingCardPoint.x == OUT_OF_MASU ) {
                    [super hiddenCardMoveTo:emptyMasuPoint markerArray:markerArray];
                } else {
                    
                    [super fillCardFrom:movingCardPoint toEmptyMasu:emptyMasuPoint];
                }
                
            }
        }
    }

}

-(void) fillCardsByDiveRotate{
    MasuPoint    emptyMasuPoint;
    MasuPoint    movingCardPoint;
    
    
    NSLog(@"button right");
    
    for ( int y = self.masuMax_y; y >= 0; y-- ) {
        for ( int x = MASU_X_MAX; x >= 0; x-- ) {
            
            emptyMasuPoint.x = x;
            emptyMasuPoint.y = y;
//            NSLog(@"searching: %d,%d", emptyMasuPoint.x, emptyMasuPoint.y);
            
            BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:emptyMasuPoint];
            if ( isEmptyMasu ) {            //空きマスが見つかったら
                movingCardPoint = [self selectMoveCardLeft:emptyMasuPoint];
                if ( movingCardPoint.x == OUT_OF_MASU ) {
//                    [super hiddenCardMoveTo:emptyMasuPoint markerArray:markerArray];
                } else {
                    
                    [self fillCardFrom:movingCardPoint toEmptyMasu:emptyMasuPoint];
                }
            }
        }
    }

}

-(void) markerRotation{
    // 回転させるためのアフィン変形を作成する
    int angle = 270;
    [super markerRotateBy:angle];
    
}

@end
