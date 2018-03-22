//
//  KSMasuManager.m
//  CardOperationTest
//
//  Created by 清水 一征 on 13/07/10.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSMasuManager.h"
#import "KSDiviceHelper.h"

@implementation KSMasuManager

static KSMasuManager    *_sharedInstance = nil;

+ (KSMasuManager *)sharedManager {
    if ( !_sharedInstance ) {
        _sharedInstance = [KSMasuManager new];
    }
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if ( !self ) {
        return nil;
    }
    _masuArray = @[].mutableCopy;
    
    if ( [KSDiviceHelper is568h] ) {
        self.intersection_y = INTERSECTION_Y_MAX;
        self.masuMax_y      = MASU_Y_MAX;
    } else {
        self.intersection_y = INTERSECTION_Y_MAX_EXCEPT_iPhone5;
        self.masuMax_y      = MASU_Y_MAX_EXCEPT_iPhone5;
    }
    
    [self makeMasues];
    
    return self;
}

#pragma mark -
#pragma mark ---------- プロパティ ----------

- (NSArray *)xPointArray { //x軸上の交点座標
    NSMutableArray    *xLine = @[].mutableCopy;
    
    for ( int x = 0; x < INTERSECTION_X_MAX; x++ ) {
        CGFloat    point = (CARD_WIDTH * x) + MARGIN_X;
        [xLine addObject:@(point)];
        
    }
    NSArray    *arr = [xLine sortedArrayUsingSelector:@selector(compare:)];
    
    return arr;
    
}

- (NSArray *)yPointArray { // y軸上の交点座標
    NSMutableArray    *yLine = @[].mutableCopy;
    
    for ( int y = 1; y < self.intersection_y + 1; y++ ) {
        
        CGFloat    point = (CARD_HIGHT * y);
        [yLine addObject:@(point)];
    }
    
    NSArray    *arr = [yLine sortedArrayUsingSelector:@selector(compare:)];
    
    return arr;
}

- (NSMutableArray *)makeLattice {
    
    NSMutableArray    *lattice = @[].mutableCopy;
    for ( int y = 0; y < [self.yPointArray count]; y++ ) {
        for ( int x = 0; x < [self.xPointArray count]; x++ ) {
            CGPoint    point = CGPointMake([[self.xPointArray objectAtIndex:x]floatValue], [[self.yPointArray objectAtIndex:y]floatValue]);
            [lattice addObject:[NSValue valueWithCGPoint:point]];
        }
    }
    
    return lattice;
}

#pragma mark -
#pragma mark ---------- Masu Array ----------
- (void)makeMasues {
    NSMutableArray    *arr = [self makeLattice];
        
    for ( NSValue *val in arr ) {
        CGPoint    point = [val CGPointValue];
        KSMasu     *masu = [[KSMasu alloc]initWithPosition:point.x y:point.y];
        masu.isCardOn = YES;
        [_masuArray addObject:masu];
    }
    
}

- (NSMutableArray *)emptyMasuArray {
    
    NSMutableArray    *pointArray = @[].mutableCopy;
    for ( KSMasu *masu in self.masuArray ) {
        if ( !masu.isCardOn ) {
            CGPoint    point = [self masuToPoint:masu.masuPoint];
            [pointArray addObject:[NSValue valueWithCGPoint:point]];
            masu.isCardOn = YES;
        }
    }
    if ( ![pointArray count] ) NSLog(@"error at %@", NSStringFromSelector(_cmd));
    
    return pointArray;
}

#pragma mark -
#pragma mark ---------- 座標／Masu変換 ----------

//// CGPointをMasuに変換
- (MasuPoint)pointToMasu:(CGPoint)point {
    
    
#define ADJUST 0.1 // 境界上を含めないようにするための定数
    
    //    pointは飛び飛びの値をとるため
    //    標準化を行う
    NSInteger std_x = point.x / (CARD_WIDTH + ADJUST);
    NSInteger std_y = (point.y - CARD_HIGHT) / (CARD_HIGHT + ADJUST);
    
    //    NSLog(@"std %d: %d ",std_x,std_y);
    
    MasuPoint m;
    m.x = std_x;// indexは０から６−１＝５
    m.y = std_y;// indexは０から９−１＝８
    
    return m;

//    NSNumber      *num_x    = @(point.x);
//    
//    
//    NSUInteger    index_x = [self.xPointArray indexOfObject:num_x];
//    
//    NSNumber      *num_y   = @(point.y);
//    NSUInteger    index_y = [self.yPointArray indexOfObject:num_y];
//    
//    MasuPoint     m;
//    m.x = (NSInteger)index_x; // indexは０から６−１＝５
//    m.y = (NSInteger)index_y; // indexは０から９−１＝８
//    return m;
}

// MasuをCGpointに変換
- (CGPoint)masuToPoint:(MasuPoint)masu {
    
    CGFloat    x = [[self.xPointArray objectAtIndex:masu.x] floatValue];
    CGFloat    y = [[self.yPointArray objectAtIndex:masu.y] floatValue];
    
    CGPoint    p = CGPointMake(x, y);
    
    return p;
}

#pragma mark -
#pragma mark ---------- マス操作 ----------

// 指定の１つ上のマスを取得
- (MasuPoint)masuAbove:(MasuPoint)masu {
    MasuPoint    mp;
    mp.x = masu.x;
    mp.y = masu.y - 1;
    if ( mp.y < 0 ) mp.y = OUT_OF_MASU;
    
    return mp;
    
}

// 指定の１つ下のマスを取得
- (MasuPoint)masuUnder:(MasuPoint)masu {
    MasuPoint    mp;
    mp.x = masu.x;
    mp.y = masu.y + 1;
    if ( mp.y > self.masuMax_y ) mp.y = OUT_OF_MASU;
    
    return mp;
    
}

// 指定の１つ右のマスを取得
- (MasuPoint)masuLeft:(MasuPoint)masu {
    MasuPoint    mp;
    mp.x = masu.x - 1;
    mp.y = masu.y;
    if ( mp.x < 0 ) mp.x = OUT_OF_MASU;
    
    return mp;
    
}

// 指定の１つ左のマスを取得
- (MasuPoint)masuRight:(MasuPoint)masu {
    MasuPoint    mp;
    mp.x = masu.x + 1;
    mp.y = masu.y;
    if ( mp.x > MASU_X_MAX ) mp.x = OUT_OF_MASU;
    
    return mp;
    
}

#pragma mark -
#pragma mark ---------- isCardOn ----------

- (void)isCardOnInit { //すべてのMasuのisCardOn をYESに
    for ( KSMasu *masu in self.masuArray ) {
        masu.isCardOn = YES;
    }
    
}

#pragma mark -
#pragma mark ---------- touch ----------
//touch point によるMasuに処理(isCardOn = YES)
- (void)didMasuTouchedAt:(CGPoint)point {
    
    for ( KSMasu *masu in self.masuArray ) {
        if ( CGRectContainsPoint(masu.frame, point)) {
            masu.isCardOn = NO;
        }
    }
    
}

@end
