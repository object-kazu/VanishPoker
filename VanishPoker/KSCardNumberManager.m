//
//  KSCardNumberManager.m
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/06.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSCardNumberManager.h"

@implementation KSCardNumberManager

static KSCardNumberManager* _sharedInstance = nil;

+ (KSCardNumberManager*) sharedManager{
    if (! _sharedInstance) {
        _sharedInstance = [KSCardNumberManager new];
    }
    
    return _sharedInstance;
}


- (id) init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _cardNumberArray = [NSMutableArray new];
    self.isDuplicate = NO;

    return self;
}


//  following function is tested at
//  KSViewController.m
//  ArrayUitTest
//
//  Created by 清水 一征 on 13/07/04.
-(void) addCardNumberWithOutDuplicate:(NSNumber*)number{
    
    
    //番号あり？
    NSUInteger index = [_cardNumberArray indexOfObject:number];
    if (index != NSNotFound) { // あり
        
        
        //同じ数値まで取り除く　１２３１なら２３１を削除
        NSInteger len = [_cardNumberArray count] - (index+1);
        [_cardNumberArray removeObjectsInRange:NSMakeRange(index+1,len)];

        
    }else{  //なし
        [_cardNumberArray addObject:number];

    }
    
}

-(void) clearCardNumberArray{

    if ([_cardNumberArray count] != 0) {
        [_cardNumberArray removeAllObjects];
    }
}


@end
