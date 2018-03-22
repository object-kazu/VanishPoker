//
//  KSYakuManager.m
//  CardOperationTest
//
//  Created by 清水 一征 on 13/07/23.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSYakuManager.h"

@interface KSYakuManager ()

@property (nonatomic) NSInteger    flashCount;
@property (nonatomic) NSInteger    straightCount;
@property (nonatomic) NSInteger    simplePairCount;
@property (nonatomic) NSInteger    flashPairCount;
@property (nonatomic) NSInteger    straightFlashCount;
@property (nonatomic) NSInteger    fourCount;
@property (nonatomic) NSInteger    loyaSFCount;

@end

@implementation KSYakuManager

- (id)init {
    self = [super init];
    if ( self ) {
        
        self.yakuArray = @[].mutableCopy;
        
        //count init
        [self clearAllYaluCount];
        
    }
    
    return self;
}

- (void)prepYakuArray:(NSArray *)markArray {
    if ( [markArray count] == 0 ) return;
    [self.yakuArray addObjectsFromArray:markArray];
}

- (void)clearYakuArray {
    [self.yakuArray removeAllObjects];
}

- (void)clearScore {
    self.score = 0;
    
}

- (void)clearAllYaluCount {
    self.flashCount         = 0;
    self.straightCount      = 0;
    self.simplePairCount    = 0;
    self.flashPairCount     = 0;
    self.straightFlashCount = 0;
    self.loyaSFCount        = 0;
    self.flashCount = 0;
}

- (void)yaku {
    
    if ( [self.yakuArray count] == 0 ) {
        NSLog(@"this method need calling prepYakuArray mthod before it use!");
        
        return;
    }
    
    //four cards?
    if ( [self isFourCard:[self.yakuArray count]] ) {
        if ( [self isFour] != 0 ) {
            self.flashCount++;
            self.score = FOUR * [self isFour];
            
            return;
        }
    }
    
    //3枚以上か？
    if ( ![self isOverThree:[self.yakuArray count]] ) { // ３枚以下
        
        // pairFlashか？
        NSInteger    fp = [self isFlashPair];
        if ( fp == 0 ) {
            //pariFlashでなければ
            self.score = 0;
            
        } else {
            // flashPairの得点を代入
            self.score = FLASHPAIR * fp;
            self.flashPairCount++;
        }
        
    } else { //3枚以上
        
        // yaku 確認
        /*
         Pairか？
         Straightか？
         Flashか？
         */
        
        if ( [self isPairCore] != 0 || [self isStraight] != 0 || [self isFlash] != 0 ) { //yakuあり
            //単役か複合役か？３枚以上の役を計算
            [self yakuCalc];
            
        } else { // yakuなし
            self.score = 0;
            
        }
    }
    
}

- (void)yakuCalc {
    if ( [self isFlash] != 0 ) { // Flash系 YES
        
        if ( [self isSimplePair] != 0 ) { // pair系 YES
            self.score = FLASHPAIR * [self isSimplePair];
            self.flashPairCount++;
            
        } else { // pair系 NO
            
            if ( [self isStraight] != 0 ) { // straigh系 YES
                
                if ( [self isLoyalStraightFlash] != 0 ) { // Loyal YES
                    self.score = LOYALSTRAIGHTFLASH * [self isLoyalStraightFlash];
                    self.loyaSFCount++;
                } else { // Loyal NO
                    self.score = STRAIGHTFLASH * [self isStraight];
                    self.straightFlashCount++;
                }
                
            } else { // straight系　NO
                self.score = FLASH * [self isFlash];
                self.flashCount++;
            }
        }
        
    } else { // Flash系　NO　ー＞　単役のみ
        if ( [self isStraight] != 0 ) { // straight系 YES
            self.score = STRAIGHT * [self isStraight];
            self.straightCount++;
            
        } else { // straight系 NO
            
            if ( [self isSimplePair] != 0 ) { // pair系　YES
                self.score = PAIR * [self isSimplePair];
                self.simplePairCount++;
            } else { // pair系　NO
                NSLog(@"error at %@", NSStringFromSelector(_cmd));
            }
        }
    }
}

- (BOOL)isOverThree:(NSInteger)count {
    bool    yaku = NO;
    
    if ( count < 3 ) { // 3枚以上でないと評価しない
        yaku = NO;
        
    } else {
        
        yaku = YES;
    }
    
    return yaku;
}

- (BOOL)isFourCard:(NSInteger)count {
    bool    yaku = NO;
    
    if ( count == 4 ) {
        yaku = YES;
        
    } else {
        
        yaku = NO;
    }
    
    return yaku;
}

#pragma mark -
#pragma mark ---------- basic yaku judge ----------

- (NSInteger)isFlash {
    NSInteger    flashCounter = 0;
    
    // はじめのマークを代入しておく
    KSMark       *mark_pre    = self.yakuArray[0];
    NSString     *first_color = mark_pre.color;
    
    for ( KSMark *mark in self.yakuArray ) {
        if ( [mark.color isEqualToString:first_color] ) {
            flashCounter++;
            //            NSLog(@"flash counter is %d",flashCounter);
        } else {
            flashCounter = 0;
            
            return flashCounter;
        }
    }
    
    return flashCounter;
}

- (NSInteger)isStraight {
    
    /*
     5 -> 4 -> 3 (-1)
     3 -> 4 -> 5 (+1)
     */
    
    //        for (KSMark* mark in self.yakuArray) {
    //            NSLog(@"mark is %@,%d,",mark.color, mark.number);
    //        }
    
    NSInteger    straightCounter = 1;
    
    // 差分をとる
    KSMark       *preMark  = self.yakuArray[0];
    KSMark       *postMark = self.yakuArray[1];
    NSInteger    diff      = preMark.number - postMark.number;
    
    // 差分が１または−１であるか確認する
    if ( diff == 1 || diff == -1 ) {
        straightCounter++;
    } else {
        //差分が１、−１でないときは０を返し終わる
        straightCounter = 0;
        
        return straightCounter;
    }
    
    // 他の要素を捜査
    for ( int i = 1; i < [self.yakuArray count] - 1; i++ ) {
        preMark  = self.yakuArray[i];
        postMark = self.yakuArray[i + 1];
        if ( diff == preMark.number - postMark.number ) {
            straightCounter++;
        } else {
            straightCounter = 0;
            
            return straightCounter;
        }
    }
    
    return straightCounter;
}

- (NSInteger)isPairCore {
    //        for (KSMark* mark in self.targetArray) {
    //            NSLog(@"mark is %@,%d",mark.color, mark.number);
    //        }
    
    NSInteger    pairCounter = 1;
    
    //何枚のpairか？
    for ( int i = 0; i < [self.yakuArray count] - 1; i++ ) {
        KSMark    *preMark  = self.yakuArray[i];
        KSMark    *postMark = self.yakuArray[i + 1];
        if ( 0 == preMark.number - postMark.number ) {
            pairCounter++;
        } else {
            pairCounter = 0;
            
            return pairCounter;
        }
    }
    
    return pairCounter;
    
}

- (NSInteger)isSimplePair {
    
    //        for (KSMark* mark in self.targetArray) {
    //            NSLog(@"mark is %@,%d",mark.color, mark.number);
    //        }
    
    // 3枚以上の必要性あり！
    if ( ![self isOverThree:[self.yakuArray count]] ) return 0;
    
    return [self isPairCore];
}

#pragma mark -
#pragma mark ---------- advance yaku ----------

- (NSInteger)isFour {
    
    bool         flag_R = NO;
    bool         flag_G = NO;
    bool         flag_B = NO;
    bool         flag_Y = NO;
    
    NSInteger    fourCardsCounter = 0;
    // すべて同じ数字か？
    if ( [self isPairCore] == 4 ) {
        // すべての色が揃っているか？
        for ( KSMark *mark in self.yakuArray ) {
            if ( [self isRed:mark] ) flag_R = YES;
            if ( [self isBlue:mark] ) flag_B = YES;
            if ( [self isGreen:mark] ) flag_G = YES;
            if ( [self isYellow:mark] ) flag_Y = YES;
        }
        
        if (flag_R) {
            if (flag_G) {
                if (flag_B) {
                    if (flag_Y) {
                        fourCardsCounter = 4;
                    }
                }
            }
        }
        
    }
    
    return fourCardsCounter; // 4枚で固定
}

- (bool)isRed:(KSMark *)mark {
    bool    is_Red = NO;
    if ( [mark.color isEqualToString:_RED_] ) {
        is_Red = YES;
    }
    
    return is_Red;
}

- (bool)isBlue:(KSMark *)mark {
    bool    is_Blue = NO;
    if ( [mark.color isEqualToString:_BLUE_] ) {
        is_Blue = YES;
    }
    
    return is_Blue;
}

- (bool)isGreen:(KSMark *)mark {
    bool    is_Green = NO;
    if ( [mark.color isEqualToString:_GREEN_] ) {
        is_Green = YES;
    }
    
    return is_Green;
}

- (bool)isYellow:(KSMark *)mark {
    bool    is_Yellow = NO;
    if ( [mark.color isEqualToString:_YELLOW_] ) {
        is_Yellow = YES;
    }
    
    return is_Yellow;
}

- (NSInteger)isFlashPair { //特殊なペアー
    
    //    for (KSMark* mark in self.targetArray) {
    //        NSLog(@"mark is %@,%d",mark.color, mark.number);
    //    }
    
    //３枚以上の必要がない！
    
    // flashを確認
    NSInteger    flash = 0;
    if ( [self.yakuArray count] >= 2 ) {
        flash = [self isFlash];
    }
    
    if ( flash == 0 ) return 0; // flashじゃない
    
    return [self isPairCore];
    
}

- (NSInteger)isStraightFlash {
    
    //    for (KSMark* mark in self.targetArray) {
    //        NSLog(@"mark is %@,%d",mark.color, mark.number);
    //    }
    
    NSInteger    flash    = [self isFlash];
    NSInteger    straight = [self isStraight];
    
    NSInteger    sf = 0;
    if ( flash != 0 && straight != 0 ) {
        if ( flash == straight ) sf = flash;
    }
    
    return sf;
}

- (NSInteger)isLoyalStraightFlash {
    if ( [self isStraightFlash] == 0 ) return 0;
    // 9,10,11,12,13の順番通りの場合だけ
    NSInteger    loyalNumbers = 9;
    
    for ( KSMark *loyalMark in self.yakuArray ) {
        if ( loyalMark.number == loyalNumbers ) {
            loyalNumbers++;
        } else {
            return 0;
        }
    }
    
    return [self isStraightFlash];
    
}

#pragma mark -
#pragma mark ---------- score & count ----------
- (NSInteger)calculatedScore {
    return self.score;
}

- (NSDictionary *)all_Yaku_Count {
    
    NSMutableDictionary    *dataDic = [@{} mutableCopy];
    dataDic[DATA_FLASH]              = @(self.flashCount);
    dataDic[DATA_STRAIGHT]           = @(self.straightCount);
    dataDic[DATA_PAIR]               = @(self.simplePairCount);
    dataDic[DATA_PAIRFLASH]          = @(self.flashPairCount);
    dataDic[DATA_STRAIGHTFLASH]      = @(self.straightFlashCount);
    dataDic[DATA_FOUR]               = @(self.fourCount);
    dataDic[DATA_LOYAL_STRAIGHFLASH] = @(self.loyaSFCount);
    
    return dataDic;
}

@end
