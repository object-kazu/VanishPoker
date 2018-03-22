//
//  KSCardNumberManager.h
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/06.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deff.h"


@interface KSCardNumberManager : NSObject
@property (nonatomic,readonly) NSMutableArray* cardNumberArray;
@property (nonatomic) BOOL isDuplicate;


+(KSCardNumberManager*) sharedManager;

// card number　操作
-(void) addCardNumberWithOutDuplicate:(NSNumber*)number;
-(void) clearCardNumberArray;

@end
