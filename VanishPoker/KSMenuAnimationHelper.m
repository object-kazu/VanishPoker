//
//  KSMenuAnimation.m
//  FlowtingMenuTest
//
//  Created by 清水 一征 on 13/08/15.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSMenuAnimationHelper.h"
#import "UIView+Addition.h"
#import "deff.h"
#import <QuartzCore/QuartzCore.h>

@interface KSMenuAnimationHelper ()

@property (nonatomic, retain) UIView    *startButton;
@property (nonatomic, retain) UIView    *showResultsButton;
@property (nonatomic) NSInteger         cardIndex;
@end

@implementation KSMenuAnimationHelper

- (id)initWithViewsArray:(NSArray *)array {
    if ( self = [super init] ) {
        if ( [array count] != ANIME_MENU_ITEM_NUMBERS ) {
            NSLog(@"Error at initWithViewsArray");
            NSLog(@"init doese not work, should use initWithViewsArray!");
        } else {
            self.startButton       = array[0];
            self.showResultsButton = array[1];
            self.cardIndex         = 0;
            
        }
    }
    
    return self;
    
}

- (id)init {
    NSMutableArray    *arr = @[].mutableCopy;
    
    return [self initWithViewsArray:arr];
}

- (void)showCard:(NSArray *)cardArray {
    KSCard    *card = cardArray[self.cardIndex];
    
    [UIView animateWithDuration:0.5f
                          delay:0.3f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         card.hidden = NO;
                         
                     } completion:^(BOOL finished) {
                         
                         if ( self.cardIndex < [cardArray count] - 1 ) {
                             self.cardIndex++;
                             [self showCard:cardArray];
                         }
                         
                     }];
    
}

- (void)showEachMenu:(UIView *)view {
    
    [UIView animateWithDuration:ANIME_SHOW_DURATION
                          delay:ANIME_SHOW_DELAY
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         view.center = CGPointMake(SCREEN_SIZE.width * 0.5 - ANIME_OVERGOING_DISTANCE, view.center.y);
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:ANIME_BACKTO_POSITION_DURATION
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              view.center = CGPointMake(SCREEN_SIZE.width * 0.5, view.center.y);
                                              
                                          } completion:^(BOOL finished) {
                                              
                                              nil;
                                              
                                          }];
                     }];
    
}

- (void)showMenu {
    
    [UIView animateWithDuration:ANIME_SHOW_DURATION
                          delay:ANIME_SHOW_DELAY
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self showEachMenu:self.startButton];
                         
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3f
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              [self showEachMenu:self.showResultsButton];
                                          } completion:^(BOOL finished) {
                                              nil;
                                          }];
                         
                     }];
    
}

- (void)hideEachMenu:(UIView *)view {
    view.left = SCREEN_SIZE.width;
    
}

- (void)hideMenu:(id)sender {
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self hideEachMenu:self.showResultsButton];
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2f
                                          animations:^{
                                              [self hideEachMenu:self.startButton];
                                          } completion:^(BOOL finished) {
                                              
                                              //delegate
                                              switch ( [sender tag] ) {
                                                  case TAG_Start:
                                                      if ( [self.delegate respondsToSelector:@selector(pushedStartButton:)] ) {
                                                          [self.delegate pushedStartButton:self];
                                                      }
                                                      break;
                                                  case TAG_ShowResults:
                                                      if ( [self.delegate respondsToSelector:@selector(pushedShowResultsButton:)] ) {
                                                          [self.delegate pushedShowResultsButton:self];
                                                      }
                                                      
                                                      break;
                                                  default:
                                                      NSLog(@"error at hideMenu, may be sender tag around");
                                                      break;
                                              }
                                              
                                          }];
                     }];
    
}

- (void)showGiveUpMenu:(UIView *)view {
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.center = CGPointMake(SCREEN_SIZE.width * 0.5, SCREEN_SIZE.height * 0.5);
                     } completion:^(BOOL finished) {
                         nil;
                     }];
}

- (void)giveUpLabelBound:(UILabel *)label {
    
    [UIView animateWithDuration:0.5f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect rect = label.frame;
                         rect.origin.y = GIVE_UP_INDICATOR_Y_POSI + 5;
                         label.frame = rect;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2f
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              CGRect rect = label.frame;
                                              rect.origin.y = GIVE_UP_INDICATOR_Y_POSI;
                                              label.frame = rect;
                                              
                                          } completion:^(BOOL finished) {
                                              nil;
                                          }];
                     }];
    
}

#define PURU_PURU_DISTANCE 10

- (void)giveUpLabelPuruPuru:(UILabel *)label {
    // puru puru animation
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = label.frame;
                         rect.origin.x += PURU_PURU_DISTANCE;
                         label.frame = rect;
                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              CGRect rect = label.frame;
                                              rect.origin.x -= PURU_PURU_DISTANCE * 2;
                                              label.frame = rect;
                                          } completion:^(BOOL finished) {
                                              
                                              [UIView animateWithDuration:0.1
                                                                    delay:0
                                                                  options:UIViewAnimationOptionCurveEaseInOut
                                                               animations:^{
                                                                   CGRect rect = label.frame;
                                                                   rect.origin.x += PURU_PURU_DISTANCE;
                                                                   label.frame = rect;
                                                                   
                                                               } completion:^(BOOL finished) {
                                                                   nil;
                                                               }];
                                              
                                          }];
                     }];
    
}

- (void)giveUpLabelHidden:(UILabel *)label {
    [UIView animateWithDuration:0.7f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         label.alpha = 0;
                     } completion:^(BOOL finished) {
                         CGRect rect = label.frame;
                         rect.origin.y = GIVE_UP_INDICATOR_height * -1;
                         label.frame = rect;
                         
                         label.alpha = 1.0;
                     }];
}

-(void) showYakuScoreLabel:(UILabel *)label{

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         CGRect rect = label.frame;
                         rect.origin.x = MENU_BASE_POSI_X + MENU_width + ADJUST_POSI_X;
                         label.frame = rect;
                         
                         label.alpha = 1.0f;
                         
                     } completion:^(BOOL finished) {
                         [self hideYakuScoreLabel:label];
                     }];
}

-(void) hideYakuScoreLabel:(UILabel*)label{
    [UIView animateWithDuration:0.2f
                          delay:1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = label.frame;
                         rect.origin.x = SCREEN_SIZE.width;
                         label.frame = rect;
                            
                         label.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self.delegate yakuScoreAnimationDidEnd:self];
                     }];
}

-(void) endingAnimation:(UIView *)view{
    [UIView animateWithDuration:1.0f
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.alpha =1;
                     } completion:^(BOOL finished) {
                         nil;
                     }];
}

@end
