//
//  KSRecord.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/18.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSRecord.h"
#import "KSDataFormatter.h"
#import <QuartzCore/QuartzCore.h>
#import "deff.h"

@implementation KSRecord

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.orderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.orderLabel];
        
        self.date = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.date];
        
        self.score = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.score];
        
        self.remainCards = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.remainCards];
        
        self.playtime = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.playtime];
        
        self.eyeCatch = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:self.eyeCatch];

        //今回はしようしない
//        self.modeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        [self addSubview:self.modeLabel];
//        
//        self.modeImg = [[UIView alloc] initWithFrame:CGRectZero];
//        [self addSubview:self.modeImg];

        CALayer    *mLayer = [self layer];
        [mLayer setMasksToBounds:NO];
        [mLayer setCornerRadius:BUTTON_CORNER_ROUND];
        //<layer shadow>
        mLayer.shadowOpacity = 0.4;
        mLayer.shadowOffset  = SHADOW_OFFSET; //self.shadowOffset;
        mLayer.shadowColor   = [COLOR_MENU_Charactors CGColor];
        
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //record view
    self.backgroundColor     = COLOR_MENU_BAR;
    
    //order label
    self.orderLabel.frame = CGRectMake(-30, -5, 20, 60);
    self.orderLabel.backgroundColor = [UIColor clearColor];
    self.orderLabel.font = [UIFont fontWithName:APPLI_FONT size:40];


    //eye catch
#define sEYE_CATCH_width         10
#define sEYE_CATCH_height        10
    
    self.eyeCatch.frame           = CGRectMake(4, 4, sEYE_CATCH_width, sEYE_CATCH_height);
    self.eyeCatch.backgroundColor = COLOR_green;
    
    
    // score label
#define SCORE_width              130
#define SCORE_height             34
#define SCORE_FONT_SIZE          18
    
    self.score.frame         = CGRectMake(sEYE_CATCH_width,
                                          sEYE_CATCH_height,
                                          SCORE_width,
                                          SCORE_height);
    
    self.score.font          = [UIFont fontWithName:APPLI_FONT size:SCORE_FONT_SIZE];
    self.score.textAlignment = NSTextAlignmentRight;
    self.score.backgroundColor = [UIColor clearColor];
    
    
    //data label
#define DATE_width               100
#define DATE_height              34
#define DATE_FONT_SIZE           18
#define SPACE_BETWEEN_SCORE_DATE 15
    
    self.date.frame           = CGRectMake(SCORE_width + SPACE_BETWEEN_SCORE_DATE,
                                           sEYE_CATCH_height,
                                           DATE_width,
                                           DATE_height);
    
    self.date.font            = [UIFont fontWithName:APPLI_FONT size:DATE_FONT_SIZE];
    self.date.textAlignment   = NSTextAlignmentRight;
    self.date.backgroundColor = [UIColor clearColor];
    
    
    // remain card
#define REMAINCARD_FONT_SIZE 14
#define REMAINCARD_width 40
#define REMAINCARD_height 20
    //Score 位置の尻に合わせる
    CGFloat calcPosition_x_remain = sEYE_CATCH_width + SCORE_width - REMAINCARD_width;

    self.remainCards.frame = CGRectMake(calcPosition_x_remain,
                                        SCORE_height +10,
                                        REMAINCARD_width,
                                        REMAINCARD_height);
    
    self.remainCards.font  = [UIFont fontWithName:APPLI_FONT size:REMAINCARD_FONT_SIZE];
    self.remainCards.textAlignment = NSTextAlignmentRight;
    self.remainCards.backgroundColor = [UIColor clearColor];
    
    
    //play time
#define PLAYTIME_FONT_SIZE 14
#define PLAYTIME_width 65
#define PLAYTIME_height 20
    
    // Date位置の尻に合わせる
    CGFloat calcPosition_x_play = self.date.frame.origin.x + DATE_width - PLAYTIME_width;
    self.playtime.frame    = CGRectMake(calcPosition_x_play,
                                        DATE_height +10,
                                        PLAYTIME_width,
                                        PLAYTIME_height);
    
    self.playtime.font = [UIFont fontWithName:APPLI_FONT size:PLAYTIME_FONT_SIZE];
    self.playtime.textAlignment = NSTextAlignmentRight;
    self.playtime.backgroundColor = [UIColor clearColor];
    
    
    //今回はしようしない 数値は参考値として
    //mode label
//    self.modeLabel.frame = CGRectMake(sEYE_CATCH_width*2,
//                                      sEYE_CATCH_height,
//                                      60, 15);
//    self.modeLabel.text = @"very long";
//    self.modeLabel.font  = [UIFont fontWithName:APPLI_FONT size:9];
//    self.modeLabel.textAlignment = NSTextAlignmentLeft;
//    self.modeLabel.backgroundColor = [UIColor redColor];
//    
//    //mode img
//    self.modeImg.frame = CGRectMake(sEYE_CATCH_width*2,
//                                    sEYE_CATCH_height* 3,
//                                    60, 20);
//    self.modeImg.backgroundColor = [UIColor blueColor];
    
    
    
}



- (void)makeRecord:(KSResults *)result {
  
    KSDataFormatter    *df = [KSDataFormatter new];
    
    //日付のフォーマット
    NSString           *str = [df displayDateFormatted:result.date];
    self.date.text = [NSString stringWithFormat:@"%@", str];
    
    //score
    NSString    *formattedScore = [df scoreFormatted:[result.score integerValue]];
    self.score.text = formattedScore;
    
    //remain cards
    self.remainCards.text = [NSString stringWithFormat:@"%@", result.remainCards];
    
    //ブレイ時間のフォーマット
    self.playtime.text = [NSString stringWithFormat:@"%@", result.playTime];
    
}

@end
