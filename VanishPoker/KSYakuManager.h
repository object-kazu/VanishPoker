//
//  KSYakuManager.h
//  CardOperationTest
//
//  Created by 清水 一征 on 13/07/23.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSMark.h"
#import "deff.h"

@interface KSYakuManager : NSObject

@property (nonatomic, retain) NSMutableArray    *yakuArray;
@property (nonatomic) NSInteger                 score;

// scoreを計算する
- (void)prepYakuArray:(NSArray *)markArray;
- (void)clearYakuArray;
- (void)clearAllYaluCount;
- (void)clearScore;
- (void)yaku;

// scoreを返す
- (NSInteger)calculatedScore;

//yaku counter
- (NSDictionary *)all_Yaku_Count;

#pragma mark -
#pragma mark ---------- private にあとで変更可（テストのためにここにある） ----------

- (BOOL)isOverThree:(NSInteger)count;
-(BOOL) isFourCard:(NSInteger) count;

- (NSInteger)isFlash;
- (NSInteger)isStraight;
- (NSInteger)isSimplePair;
- (NSInteger)isFlashPair;
- (NSInteger) isFour;
- (NSInteger)isStraightFlash;
- (NSInteger)isLoyalStraightFlash;
-(bool) isRed:(KSMark*) mark;
-(bool) isBlue:(KSMark*) mark;
-(bool) isYellow:(KSMark*) mark;
-(bool) isGreen:(KSMark*) mark;

#pragma mark -
#pragma mark ---------- ここまで ----------

@end
