//
//  KSRecordAnimationHelper.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/19.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSRecordAnimationHelper.h"
#import "UIView+Addition.h"
#import "deff.h"

@interface KSRecordAnimationHelper ()

@end

@implementation KSRecordAnimationHelper

- (void)showEachRecord:(KSRecord *)record {

    record.left = EYE_CATCH_width;
    
}

- (void)showRecord:(NSArray *)recordArray {
    
    for ( KSRecord *rec in recordArray ) {
        CGFloat    duration = (arc4random() % 10 + 1) * 0.1; // 0.1 ~ 0.9の乱数
        CGFloat    delay    = (arc4random() % 3 + 1) * 0.1;  // 0.1 ~ 0.3の乱数
        
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self showEachRecord:rec];
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    
}

@end
