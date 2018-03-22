//
//  KSMarkManager.m
//  CardOperationTest
//
//  Created by 清水 一征 on 13/07/18.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSMarkManager.h"


#warning ending testのため変更
const NSString    *Colors = @"rgby";
//const NSString    *Colors = @"rrrr";


@implementation KSMarkManager

- (id)init {
    self = [super init];
    if ( self ) {
        srandom(time(nil));
        _markerCount = 0;

    }
    
    return self;
}

#pragma mark -
#pragma mark ---------- get random number ----------
- (NSMutableArray *)randomNumbers {
    
    NSMutableArray    *serialArray = [NSMutableArray array]; // 1~13までのシリアルナンバーを格納する
    NSMutableArray    *randomArray = [NSMutableArray array]; //1~13までのランダムナンバーを格納する
    
    //乱数のseed
    
    //1~13までの配列を用意しておいて、その後ランダムに配列から数字を抜いていく
    for ( int j = 1; j <= CARD_NUMBER_MAX; j++ ) {
        [serialArray addObject:@(j)];
    }
    
    
    for ( int ii = 1; ii <= CARD_NUMBER_MAX; ii++ ) {
        NSInteger    size    = CARD_NUMBER_MAX - ii + 1;
        NSInteger    myIndex = random() % size;
        
        [randomArray addObject:[serialArray objectAtIndex:myIndex]];
        [serialArray removeObjectAtIndex:myIndex];
    }
    return randomArray;
    
    
}

#pragma mark -
#pragma mark ---------- Marker ----------
- (NSMutableArray *)makeMarkers {
    
    NSMutableArray    *arr = @[].mutableCopy;
    
    for ( int j = 0; j < Colors.length; j++ ) {
        NSString          *c           = [Colors substringWithRange:NSMakeRange(j, 1)];
        NSMutableArray    *randomArray = [self randomNumbers];
        
        for ( int i = 1; i <= CARD_NUMBER_MAX; i++ ) {
            KSMark    *m = [KSMark new];
            m.color  = c;
            m.number = [[randomArray objectAtIndex:i - 1] intValue];
            [arr addObject:m];
            m = nil;
            
        }
    }
    
    //    NSLog(@"arr count %d", [arr count]);
    //    for (int s = 0; s < [arr count]; s++) {
    //        KSMark *ma = [arr objectAtIndex:s];
    //        NSLog(@"%d => %@, %d", s, ma.color, ma.number);
    //    }
    
    return arr;
}

- (NSArray *)shuffleMarks {
    // maker を　ランダムに配列する
    //色は４種、それぞれ１３個用意する　＝＞　４ｘ１３　＝５２
    NSMutableArray    *original   = [self makeMarkers];
    NSInteger         arrayLength = [original count];
    NSMutableArray    *newArray   = @[].mutableCopy;
    
    for ( int index = 0; index < arrayLength; index++ ) {
        NSInteger    size = [original count];
        //        NSLog(@"index %d, size %d, original %d",index, size, [original count]);
        NSInteger    newIndex = arc4random() % size;
        
        [newArray addObject:[original objectAtIndex:newIndex]];
        [original removeObjectAtIndex:newIndex];
        
    }
    
    //    for (KSMark* m in newArray) {
    //        NSLog(@"%@, %d",m.color, m.number);
    //    }
    
    return (NSArray *)newArray;
    
}

- (NSString *)colorStringSwitcher:(NSInteger)index {
    NSString    *str;
    NSString    *result;
    
    if ( [Colors length] < index ) return _BLACK_;
    
    str = [Colors substringWithRange:NSMakeRange(index, 1)];
    if ( [str isEqualToString:@"r"] ) {
        result = _RED_;
    } else if ( [str isEqualToString:@"g"] ) {
        result = _GREEN_;
    } else if ( [str isEqualToString:@"b"] ) {
        result = _BLUE_;
    } else if ( [str isEqualToString:@"y"] ) {
        result = _YELLOW_;
    } else {
        result = _BLACK_;
    }
    
    return result;
}

#pragma mark -
#pragma mark ---------- Marker set ----------

// setを作成する
// 2 set = 52 x 2
- (NSMutableArray *)makeMarkSets:(NSInteger)setNumber {
    NSMutableArray    *totalArray = @[].mutableCopy;
    
    for ( int i = 0; i < setNumber; i++ ) {
        NSArray    *pieceArr = [self shuffleMarks];
        [totalArray addObjectsFromArray:pieceArr];
    }
    
    return totalArray;
}

-(BOOL) canDecreaseMarkerCount{
    if (self.markerCount > 0) {
        return YES;
    }else{
        return NO;
    }
}



#pragma mark -
#pragma mark ---------- for unit test ----------

- (NSMutableArray *)makeStraight {
    
    NSMutableArray    *arr = @[].mutableCopy;
    

    for ( int i = 1; i <= CARD_NUMBER_MAX; i++ ) {
            KSMark    *m = [KSMark new];
            
            NSInteger k = arc4random() % Colors.length;
            NSString *c = [Colors substringWithRange:NSMakeRange(k, 1)];

//        NSLog(@"k value %d",k);
//        NSLog(@"string c is %@",c);
        
            m.color  = c;
            m.number = i;
            [arr addObject:m];
            m = nil;
            
        }
    
    return arr;
}


- (NSMutableArray *)makeStraightFlash {
    
    NSMutableArray    *arr = @[].mutableCopy;
    
    for ( int j = 0; j < Colors.length; j++ ) {
        NSString          *c           = [Colors substringWithRange:NSMakeRange(j, 1)];
       
        
        for ( int i = 1; i <= CARD_NUMBER_MAX; i++ ) {
            KSMark    *m = [KSMark new];
            m.color  = c;
            m.number = i;
            [arr addObject:m];
            m = nil;
            
        }
    }

    return arr;
}
- (NSMutableArray *)makeFlashPairMarkers {
    
    NSMutableArray    *arr = @[].mutableCopy;
    
    for ( int j = 0; j < Colors.length; j++ ) {
        NSString          *c           = [Colors substringWithRange:NSMakeRange(j, 1)];
        
        
        for ( int i = 1; i <= CARD_NUMBER_MAX; i++ ) {
            KSMark    *m = [KSMark new];
            m.color  = c;
            m.number = 1;
            [arr addObject:m];
            m = nil;
            
        }
    }
    
    return arr;
}

- (NSMutableArray *)makePairMarkers {
    
    NSMutableArray    *arr = @[].mutableCopy;
    
    for ( int j = 0; j < Colors.length; j++ ) {
        NSString          *c           = [Colors substringWithRange:NSMakeRange(j, 1)];
        KSMark    *m = [KSMark new];
        m.color  = c;
        m.number = 1;
        [arr addObject:m];
        m = nil;

    }
    
    return arr;
}

-(NSMutableArray*) makeLoyalStraightFlash:(NSInteger)begining{

    
    NSMutableArray    *arr = @[].mutableCopy;
    
    if (begining > 13 || begining < 0 ) {
        begining = 13;
    }
    
    for ( int j = 0; j < Colors.length; j++ ) {
        NSString          *c           = [Colors substringWithRange:NSMakeRange(j, 1)];
        
        
        for ( int i = begining; i <= CARD_NUMBER_MAX; i++ ) {
            KSMark    *m = [KSMark new];
            m.color  = c;
            m.number = i;
            [arr addObject:m];
            m = nil;
            
        }
    }
    
    return arr;
}


@end
