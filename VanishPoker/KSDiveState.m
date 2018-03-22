//
//  KSDiveState.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/09/03.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSDiveState.h"
#import "KSCardManager.h"
#import "KSMasuManager.h"
#import "KSCard.h"
#import "KSMarkManager.h"
#import "KSDiviceHelper.h"
#import "deff.h"

@interface KSDiveState ()

@property (nonatomic, retain) KSMasuManager    *masuManager;

@end

@implementation KSDiveState

static KSDiveState    *_sharedInstance = nil;

+ (KSDiveState *)sharedState {
    if ( !_sharedInstance ) {
        _sharedInstance = [self new];
    }
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }
    
    // インスタンス変数を初期化する
    self.masuManager = [KSMasuManager new];
    self.markManager = [KSMarkManager new];
    
    return self;
}

- (NSInteger)masuMax_y {
    // divice
    if ( [KSDiviceHelper is568h] ) {
        return MASU_Y_MAX;
    } else {
        return MASU_Y_MAX_EXCEPT_iPhone5;
    }
    
}

- (void)searching:(NSMutableArray *)markerArray {
    
}

- (void)markerRotation {
    
}

- (void)fillCardsByDiveRotate {
    
}

- (void)markerRotateBy:(int)angle {
    // 回転させるためのアフィン変形を作成する
    CGAffineTransform    t = CGAffineTransformMakeRotation(angle * M_PI / 180);
    
    // 回転させるのにアニメーションをかけてみた
    for ( KSCard *card in [KSCardManager sharedManager].cardArray ) {
        
        [UIView animateWithDuration:ANIME_MARKER_ROTATE_SPEED
                              delay:ANIME_MARKER_TORATE_DELAY
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             card.marker.transform = t;
                             
                         } completion:^(BOOL finished) {
                             
                         }];
        
    }
    
}

- (MasuPoint)selectMoveCardAbove:(MasuPoint)masu {
    // 空きマスの上のCardがあるマスを返す
    //１つ上を捜査
    MasuPoint    up = [_masuManager masuAbove:masu];
    
    if ( up.y == OUT_OF_MASU ) return up;
    
    BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:up];
    if ( isEmptyMasu ) {
        up = [self selectMoveCardAbove:up];
    }
    
    return up;
}

- (MasuPoint)selectMoveCardUnder:(MasuPoint)masu {
    // 空きマスの上のCardがあるマスを返す
    //１つ上を捜査
    MasuPoint    under = [_masuManager masuUnder:masu];
    
    if ( under.y == OUT_OF_MASU ) return under;
    
    BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:under];
    if ( isEmptyMasu ) {
        under = [self selectMoveCardUnder:under];
    }
    
    return under;
}

- (MasuPoint)selectMoveCardLeft:(MasuPoint)masu {
    // 空きマスの上のCardがあるマスを返す
    MasuPoint    left = [_masuManager masuLeft:masu];
    
    if ( left.x == OUT_OF_MASU ) return left;
    
    BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:left];
    if ( isEmptyMasu ) {
        left = [self selectMoveCardLeft:left];
    }
    
    return left;
}

- (MasuPoint)selectMoveCardRight:(MasuPoint)masu {
    // 空きマスの上のCardがあるマスを返す
    MasuPoint    right = [_masuManager masuRight:masu];
    
    if ( right.x == OUT_OF_MASU ) return right;
    
    BOOL    isEmptyMasu = [[KSCardManager sharedManager] isEmptyCardAt:right];
    if ( isEmptyMasu ) {
        right = [self selectMoveCardRight:right];
    }
    
    return right;
}

- (void)fillCardFrom:(MasuPoint)fillcard toEmptyMasu:(MasuPoint)empty {
    
    KSCard    *up_card = [[KSCardManager sharedManager] cardAt:fillcard];
    
    [UIView animateWithDuration:ANIME_FILL_CARD_DURATION
                          delay:ANIME_FILL_CARD_DELAY
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [up_card cardAt:empty];
                         
                         UIImage *img = [[KSCardManager sharedManager] cardColorConvertUIimage:up_card.mark.color];
                         [up_card.backImg setImage:img];
                         
                     } completion:^(BOOL finished) {
                         nil;
                     }];
    
}

- (void)hiddenCardMoveTo:(MasuPoint)masu markerArray:(NSMutableArray *)markerArray {
    // 開いているmasuにCardを移動
    
    // markerCountが０より大きいときはカードを補充する
    //0より小さい時は補充しない
    
    if ( !self.markManager.canDecreaseMarkerCount ) return;
    
    for ( KSCard *card in [KSCardManager sharedManager].cardArray ) {
        if ( card.hidden ) {
            // card Markerの更新
            card.mark = [markerArray objectAtIndex:self.markManager.markerCount];
            
            self.markManager.markerCount--;
            [self displayCardNumber:card number:card.mark.number];
            
            card.hidden = NO;
            
            UIImage    *img = [[KSCardManager sharedManager] cardColorConvertUIimage:card.mark.color];
            [card.backImg setImage:img];
            card.alpha = 0;
            
            [UIView animateWithDuration:ANIME_HIDDEN_CARD_DURATION
                                  delay:ANIME_REMOVE_CARD_DELAY
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 [card cardAt:masu];
                                 card.alpha = 0.7f;
                                 
                             } completion:^(BOOL finished) {
                                 card.alpha = 1.0f;
                             }];
            
            return;
        }
    }
}

- (void)displayCardNumber:(KSCard *)card number:(NSInteger)number {
    card.marker.text = [NSString stringWithFormat:@"%d", card.mark.number ];
    
}

@end
