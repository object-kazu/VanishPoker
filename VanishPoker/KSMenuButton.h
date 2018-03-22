//
//  KSOriginalButton.h
//  FlowtingMenuTest
//
//  Created by 清水 一征 on 13/08/14.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "deff.h"

@interface KSMenuButton : UIButton

@property (nonatomic, retain) UILabel    *eyeCatch; // one point accent
@property (nonatomic, retain) UILabel    *subjectLabel;
@property (nonatomic, retain) UILabel    *numberLabel;
@property (nonatomic) CGRect             subjectRect;
@property (nonatomic) CGRect             numberRect;

#pragma mark -
#pragma mark ---------- each button ----------
-(KSMenuButton*) startButton;
-(KSMenuButton*) showResultsButton;
-(KSMenuButton*) reStartButon;
-(KSMenuButton*) giveUpButton;
-(KSMenuButton*) cancelButton;
-(KSMenuButton*) timerButton;
-(KSMenuButton*) scoreButton;
-(KSMenuButton*) doneButton;

-(KSMenuButton*) endingButton:(NSInteger)score;

@end
