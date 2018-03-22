//
//  KSRecord.h
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/18.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSResults.h"

@interface KSRecord : UIView

@property (nonatomic, retain) UILabel    *date;
@property (nonatomic, retain) UILabel    *score;
@property (nonatomic, retain) UILabel    *remainCards;
@property (nonatomic, retain) UILabel    *playtime;
@property (nonatomic, retain) UILabel    *eyeCatch; // one point accent
@property (nonatomic, retain) UILabel    *orderLabel;

// mode　今回は使用しない
@property (nonatomic, retain) UILabel    *modeLabel;
@property (nonatomic, retain) UIView     *modeImg;

- (void)makeRecord:(KSResults *)result;

@end
