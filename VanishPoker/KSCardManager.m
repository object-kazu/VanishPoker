//
//  KSCardController.m
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/04.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSCardManager.h"
#import "KSDiviceHelper.h"

@interface KSCardManager ()

@property (nonatomic, retain) KSCard                   *cardAtPointing;
@property (nonatomic, retain) KSCard                   *cardAtPointed;
@property (nonatomic) NSInteger                        y_Max;
@property (nonatomic, retain) NSMutableDictionary      *cardImgDic;

//dammy card
@property (nonatomic) NSMutableArray* cardArrayForDammyCardBack;
@property (nonatomic) NSInteger index;
    

@end

@implementation KSCardManager

static KSCardManager    *_sharedInstance = nil;

+ (KSCardManager *)sharedManager {
    if ( !_sharedInstance ) {
        _sharedInstance = [KSCardManager new];
    }
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }
    _cardArray            = [NSMutableArray new];
    _mManager             = [KSMasuManager new];
    self.coloredCardArray = @[].mutableCopy;
    self.cardAtPointed    = [KSCard new];
    self.cardAtPointing   = [KSCard new];
    
    self.cardImgDic = [@{} mutableCopy];
    UIImage    *rImg = [UIImage imageNamed:@"redcard"];
    UIImage    *bImg = [UIImage imageNamed:@"bluecard"];
    UIImage    *gImg = [UIImage imageNamed:@"greencard"];
    UIImage    *yImg = [UIImage imageNamed:@"yellowcard"];
    
    self.cardImgDic[CARD_COLOR_RED]    = rImg;
    self.cardImgDic[CARD_COLOR_BLUE]   = bImg;
    self.cardImgDic[CARD_COLOR_GREEN]  = gImg;
    self.cardImgDic[CARD_COLOR_YELLOW] = yImg;
    
    
    self.index = 0;
    self.cardArrayForDammyCardBack = @[].mutableCopy;
    
    return self;
}

#pragma mark -
#pragma mark ---------- property ----------

- (CGFloat)reservePosition_TOP_y {
    return CARD_HIGHT * -1;
}

- (CGFloat)reservePosition_BOTTOM_y {
    
    return SCREEN_SIZE.height + CARD_HIGHT * 1;
    
}

- (CGFloat)reservePosition_LEFT_x {
    return CARD_WIDTH * -1;
}

- (CGFloat)reservePosition_RIGHT_x {
    
    return SCREEN_SIZE.width + CARD_WIDTH * 1;
}

- (NSInteger)y_Max {
    NSInteger    y;
    // divice
    if ( [KSDiviceHelper is568h] ) {
        y = MASU_Y_MAX;
    } else {
        y = MASU_Y_MAX_EXCEPT_iPhone5;
    }
    
    return y;
}

#pragma mark -
#pragma mark ---------- touch ----------
- (void)touchedCardAt:(CGPoint)point {
    
    // touch 間違いを補正する
    //　間違いをViewControllerに知らせて表示をキャンセルさせる
    
    for ( KSCard *card in self.cardArray ) {
        if ( CGRectContainsPoint(card.frame, point)) {
            NSNumber    *number = @(card.tag);
            [[KSCardNumberManager sharedManager] addCardNumberWithOutDuplicate:number];
            
        }
    }
    
}

- (void)coloredCard:(CGPoint)point {
    
    if ( CGRectIsEmpty(self.cardAtPointed.frame)) { // 前のCard情報がない場合
        //基準となるカード情報を設定する
        [self startingTouchingCard:point];
    }
    
    if ( [self isPointingCardChanged:point] ) { // 違うカードが選択されたなら
        for ( KSCard *card in self.cardArray ) {
            if ( CGRectContainsPoint(card.frame, point)) {
                if ( card.backgroundColor == COLOR_SELECTED ) { // すでに選択済みのカードの場合
                    KSCard    *card = [self.coloredCardArray lastObject];
                    card.backgroundColor = [self cardColorConvertUIColor:card.mark.color];
                    card.backImg.alpha   = 1.0f;
                    [self.coloredCardArray removeLastObject];
                    
                } else { // まだ選択されたことがないカードの場合
                    [self cardSelected:card];
                    
                    break;
                    
                }
            }
        }
        
    }
    
}

- (void)cardSelected:(KSCard *)card {
    [self.coloredCardArray addObject:card];
    card.backgroundColor = COLOR_SELECTED;
    card.backImg.alpha   = 0.5f;
    card.alpha = 0.2f;
    
}

- (void)beginingColordCard:(CGPoint)point { //  touch 開始時のみ呼び出すこと
    for ( KSCard *card in self.cardArray ) {
        if ( CGRectContainsPoint(card.frame, point)) {
            [self cardSelected:card];
            
            break;
            
        }
    }
    
}

- (void)startingTouchingCard:(CGPoint)point {
    for ( KSCard *card in self.cardArray ) {
        if ( CGRectContainsPoint(card.frame, point)) {
            self.cardAtPointed = card;
            break;
        }
    }
    
}

- (BOOL)isPointingCardChanged:(CGPoint)point {
    
    // startingTouchingCardで設定がされているか？
    if ( CGRectIsEmpty(self.cardAtPointed.frame)) {
        //設定がされていなければ
        NSLog(@"should set the self.cardAtPointed at startingTouchingCard");
    }
    
    for ( KSCard *card in self.cardArray ) {
        if ( CGRectContainsPoint(card.frame, point)) {
            self.cardAtPointing = card;
            break;
        }
    }
    
    BOOL    isPointingCardSame = CGRectIntersectsRect(self.cardAtPointing.frame, self.cardAtPointed.frame);
    if ( isPointingCardSame ) { // pointing cardが同じ
        
        return NO;
    } else { // pointing card違う
        //入れ替えを行う
        self.cardAtPointed = self.cardAtPointing;
        
        return YES;
    }
    
}


- (void)refreshColoredCard {
    for ( KSCard *card in self.coloredCardArray ) {
        
        card.backgroundColor = [self cardColorConvertUIColor:card.mark.color];
        card.backImg.alpha   = 1.0f;
        card.alpha = 1.0f;
    }
    
    [self.coloredCardArray removeAllObjects];
    self.cardAtPointing = nil;
    self.cardAtPointed  = nil;
    
}

-(void) checkedColoredCard{
    for ( KSCard *card in self.cardArray ) {
        if (card.alpha != 1.0f) {
            card.alpha = 1.0f;
        }
    }
    
}

#pragma mark -
#pragma mark ---------- search masu ----------
- (BOOL)isEmptyCardAt:(MasuPoint)masu {
    
    BOOL             isEmpty = YES;
    
    KSMasuManager    *mm = [KSMasuManager new];
    CGPoint          p   = [mm masuToPoint:masu];
    for ( KSCard *card in self.cardArray ) {
        if ( CGRectContainsPoint(card.frame, p)) {
            isEmpty = NO;
        }
    }
    
    return isEmpty;
}

- (BOOL)isEmptyCardAtPoint:(CGPoint)point {
    BOOL    isEmpty = YES;
    
    for ( KSCard *card in self.cardArray ) {
        if ( CGRectContainsPoint(card.frame, point)) {
            isEmpty = NO;
        }
    }
    
    return isEmpty;
    
}

#pragma mark -
#pragma mark ---------- Card Reserve position----------

- (CGRect)moveCardToReservePosition:(CGRect)CardFrame direction:(deviceDirection)direction {
    
    CGFloat    ori_x = CardFrame.origin.x;
    CGFloat    ori_y = CardFrame.origin.y;
    
    CGRect     rec;
    
    switch ( direction ) {
        case HOMEButton_Down:
            rec = CGRectMake(ori_x, self.reservePosition_TOP_y, CARD_WIDTH, CARD_HIGHT);
            break;
            
        case HOMEButton_Top:
            rec = CGRectMake(ori_x, self.reservePosition_BOTTOM_y, CARD_WIDTH, CARD_HIGHT);
            break;
            
        case HOMEButton_Left:
            rec = CGRectMake(self.reservePosition_RIGHT_x, ori_y, CARD_WIDTH, CARD_HIGHT);
            break;
            
        case HOMEButton_Right:
            rec = CGRectMake(self.reservePosition_LEFT_x, ori_y, CARD_WIDTH, CARD_HIGHT);
            break;
            
        default:
            NSLog(@"error at %@", NSStringFromSelector(_cmd));
            break;
    }
    
    return rec;
}

#pragma mark -
#pragma mark ---------- Card 操作----------
- (void)addCard:(KSCard *)card {
    
    // 引数確認
    if ( !card ) return;
    
    [_cardArray addObject:card];
    
}

// 指定されたMasuにあるKScardを得る
- (KSCard *)cardAt:(MasuPoint)point {
    
    KSCard     *targetCard;
    
    CGPoint    p = [[KSMasuManager sharedManager] masuToPoint:point];
    
    for ( KSCard *card in self.cardArray ) {
        if ( CGRectContainsPoint(card.frame, p)) {
            targetCard = card;
        }
    }
    
    return targetCard;
    
}

#pragma mark -
#pragma mark ---------- dammy ----------


-(void) moveDammyCard:(KSCard *)dammy at:(MasuPoint)mp{
//    MasuPoint mp_pre = dammy.masu;
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [dammy cardAt:mp];
                     } completion:^(BOOL finished) {
                         nil;
                     }];
    
//    [dammy cardAt:mp];

    
}

-(void) moveBackDammyCard:(KSCard *)dammy at:(NSArray *)street{
    NSArray* reverse = [[street reverseObjectEnumerator] allObjects];
    [self.cardArrayForDammyCardBack addObjectsFromArray:reverse];
    
    KSCard* preCard = self.cardArrayForDammyCardBack[self.index];
    [self cardBackHomeAnimation:dammy backTo:preCard];
    
    
//    NSEnumerator *reverseArray = [street reverseObjectEnumerator];
//    for (KSCard* card in reverseArray) {
//        NSLog(@"card info :(x,y) : %d,%d",card.masu.x, card.masu.y);
//        
//        [self cardBackHomeAnimation:dammy backTo:card.masu];
//        
//        
//        
//        
//        
//    }
    dammy.hidden = YES;
    self.index = 0;
    [self.cardArrayForDammyCardBack removeAllObjects];

    
}

-(void) cardBackHomeAnimation:(KSCard*)card backTo:(KSCard*)preCard{

    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [card cardAt:preCard.masu];
                         
                     } completion:^(BOOL finished) {
                         
                         if (self.index < [self.cardArrayForDammyCardBack count]) {
                             self.index++;
                             KSCard* nextCard = self.cardArrayForDammyCardBack[self.index];
                             [self cardBackHomeAnimation:card backTo:nextCard];
                         }
                     }];
//    self.index = 0;
//    [self.cardArrayForDammyCardBack removeAllObjects];

}


#pragma mark -
#pragma mark ---------- ending ----------
- (BOOL)isEnd:(NSArray *)searchMashs {
    
    for ( NSValue *val in searchMashs ) {
        MasuPoint    mp;
        [val getValue:&mp];
        
        if ( ![self isEmptyCardAt:mp] ) {
            return NO;
        }
    }
    
    return YES;
}

- (NSArray *)searchMasuArray:(deviceDirection)direction {
    
    NSMutableArray    *masuArray = @[].mutableCopy;
    
    switch ( direction ) {
        case HOMEButton_Down:
            for ( int x = 0; x < MASU_X_MAX + 1; x++ ) {
                MasuPoint    mp;
                mp.x = x;
                mp.y = self.y_Max;
                
                [masuArray addObject:[NSValue value:&mp withObjCType:@encode(MasuPoint)]];
            }
            
            break;
        case HOMEButton_Top:
            for ( int x = 0; x < MASU_X_MAX + 1; x++ ) {
                MasuPoint    mp;
                mp.x = x;
                mp.y = 0;
                
                [masuArray addObject:[NSValue value:&mp withObjCType:@encode(MasuPoint)]];
            }
            
            break;
        case HOMEButton_Left:
            
            for ( int y = 0; y < self.y_Max + 1; y++ ) {
                MasuPoint    mp;
                mp.x = 0;
                mp.y = y;
                
                [masuArray addObject:[NSValue value:&mp withObjCType:@encode(MasuPoint)]];
            }
            
            break;
        case HOMEButton_Right:
            
            for ( int y = 0; y < self.y_Max + 1; y++ ) {
                MasuPoint    mp;
                mp.x = MASU_X_MAX;
                mp.y = y;
                
                [masuArray addObject:[NSValue value:&mp withObjCType:@encode(MasuPoint)]];
            }
            
            break;
            
        default:
            break;
    }
    
    return masuArray;
}

#pragma mark -
#pragma mark ---------- number of remain cards ----------
- (NSInteger)remainCardsWithStock:(NSInteger)markerCount {
    
    // marker count ＞０なら　盤面のマスには全てカードがるので
    //マス数＋markerCount
    
    if ( markerCount > 0 ) {
        return ((MASU_X_MAX + 1) * (self.y_Max + 1)) + markerCount;
        
    } else { // stockなし。盤面の残りのカードを数える
        return [self countCardOnTheMasu];
        
    }
    
}

- (NSInteger)countCardOnTheMasu {
    NSInteger    masuCounter = 0;
    for ( int x = 0; x < MASU_X_MAX + 1; x++ ) {
        for ( int y = 0; y < self.y_Max + 1; y++ ) {
//            NSLog(@"x:%d, y:%d", x, y);
            MasuPoint    mp;
            mp.x = x;
            mp.y = y;
            if ( ![self isEmptyCardAt:mp] ) {
                masuCounter++;
            }
        }
    }
    
    return masuCounter;
}

- (UIImage *)cardColorConvertUIimage:(NSString *)cardColor {
    
    UIImage    *cardImg;
    
    if ( [cardColor isEqualToString:_RED_] ) {
        cardImg = self.cardImgDic[CARD_COLOR_RED];
    }
    
    if ( [cardColor isEqualToString:_BLUE_] ) {
        cardImg = self.cardImgDic[CARD_COLOR_BLUE];
    }
    
    if ( [cardColor isEqualToString:_YELLOW_] ) {
        cardImg = self.cardImgDic[CARD_COLOR_YELLOW];
    }
    
    if ( [cardColor isEqualToString:_GREEN_] ) {
        cardImg = self.cardImgDic[CARD_COLOR_GREEN];
    }
    
    return cardImg;
    
}

- (UIColor *)cardColorConvertUIColor:(NSString *)cardColor {
    UIColor    *color = [UIColor blackColor];
    
    if ( [cardColor isEqualToString:_RED_] ) {
        color = [UIColor redColor];
    }
    
    if ( [cardColor isEqualToString:_BLUE_] ) {
        color = [UIColor blueColor];
    }
    
    if ( [cardColor isEqualToString:_YELLOW_] ) {
        color = [UIColor yellowColor];
    }
    
    if ( [cardColor isEqualToString:_GREEN_] ) {
        color = [UIColor greenColor];
    }
    
    return color;
}

@end
