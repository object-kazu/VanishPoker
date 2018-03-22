//
//  KSCardController.h
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/04.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCard.h"
#import "KSCardNumberManager.h"
#import "deff.h"
#import "KSMasuManager.h"
#import "KSMasu.h"

#pragma mark -
#pragma mark ---------- reserve position ----------

@interface KSCardManager : NSObject

@property (nonatomic, retain) NSMutableArray    *cardArray;
@property (nonatomic, retain) NSMutableArray    *coloredCardArray;

+ (KSCardManager *)sharedManager;

#pragma mark -
#pragma mark ---------- masu manager ----------
@property (nonatomic, retain) KSMasuManager    *mManager;

#pragma mark -
#pragma mark ---------- ending ----------
- (BOOL)isEnd:(NSArray *)searchMashs;
- (NSArray *)searchMasuArray:(deviceDirection)direction;

#pragma mark -
#pragma mark ---------- touch ----------
- (void)touchedCardAt:(CGPoint)point;
- (void)startingTouchingCard:(CGPoint)point;

#pragma mark -
#pragma mark ---------- 一時的：Colored　Card ----------
- (void)coloredCard:(CGPoint)point;
- (void)beginingColordCard:(CGPoint)point;
- (void)refreshColoredCard;

#pragma mark -
#pragma mark ---------- search ----------
- (BOOL)isEmptyCardAt:(MasuPoint)masu;
- (BOOL)isEmptyCardAtPoint:(CGPoint)point;

#pragma mark -
#pragma mark ---------- Card Reserve Position ----------
@property (nonatomic) CGFloat    reservePosition_TOP_y;
@property (nonatomic) CGFloat    reservePosition_BOTTOM_y;
@property (nonatomic) CGFloat    reservePosition_LEFT_x;
@property (nonatomic) CGFloat    reservePosition_RIGHT_x;

- (CGRect)moveCardToReservePosition:(CGRect)CardFrame direction:(deviceDirection)direction;

#pragma mark -
#pragma mark ---------- Card操作 ----------
// cardの操作
- (void)addCard:(KSCard *)card;
- (KSCard *)cardAt:(MasuPoint)point; //指定されたMasuのカードを得る

#pragma mark -
#pragma mark ---------- dammy ----------
-(void) moveDammyCard:(KSCard*)dammy at:(MasuPoint)mp;
-(void) moveBackDammyCard:(KSCard*) dammy at:(NSArray*) street;
-(void) checkedColoredCard;

#pragma mark -
#pragma mark ---------- number of remain cards ----------
- (NSInteger)remainCardsWithStock:(NSInteger)markerCount;

#pragma mark -
#pragma mark ---------- color convert to img  ----------
- (UIImage *)cardColorConvertUIimage:(NSString *)cardColor;
- (UIColor *)cardColorConvertUIColor:(NSString *)cardColor;

@end
