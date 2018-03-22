//
//  KSMarkManager.h
//  CardOperationTest
//
//  Created by 清水 一征 on 13/07/18.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSMark.h"
#import "deff.h"

@interface KSMarkManager : NSObject

@property (nonatomic, retain) KSMark    *mark;
@property (nonatomic) NSInteger         markerCount;

- (NSString *)colorStringSwitcher:(NSInteger)index;
- (NSMutableArray *)makeMarkers;
- (NSArray *)shuffleMarks;
- (NSMutableArray *)makeMarkSets:(NSInteger)setNumber;
- (BOOL)canDecreaseMarkerCount;

#pragma mark -
#pragma mark ---------- for unit test ----------
- (NSMutableArray *)makeStraightFlash;
- (NSMutableArray *)makeFlashPairMarkers;
- (NSMutableArray *)makePairMarkers;
- (NSMutableArray *)makeStraight;
- (NSMutableArray *)makeLoyalStraightFlash:(NSInteger)begining;

@end
