//
//  KSMenuAnimation.h
//  FlowtingMenuTest
//
//  Created by 清水 一征 on 13/08/15.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSCard.h"

@interface KSMenuAnimationHelper : NSObject

@property (nonatomic, assign) id                delegate;

@property (nonatomic, retain) NSMutableArray    *buttonArray;
- (id)initWithViewsArray:(NSArray *)array;
- (void)showMenu;
- (void)hideMenu:(id)sender;
- (void)showGiveUpMenu:(UIView *)view;
- (void)giveUpLabelBound:(UILabel *)label;
- (void)giveUpLabelPuruPuru:(UILabel *)label;
- (void)giveUpLabelHidden:(UILabel *)label;
- (void)showCard:(NSArray *)cardArray;
- (void)showYakuScoreLabel:(UILabel *)label;
- (void)endingAnimation:(UIView *)view;

@end

//child view delegate
@interface NSObject (KSMenuAnimationHelper)

- (void)pushedShowResultsButton:(KSMenuAnimationHelper *)helper;
- (void)pushedStartButton:(KSMenuAnimationHelper *)helper;
- (void)yakuScoreAnimationDidEnd:(KSMenuAnimationHelper *)helper;
- (void)cancelGiveUpAndCancelMenu:(KSMenuAnimationHelper *)helper;

@end
