//
//  KSLabel.m
//  VanishPoker
//
//  Created by 清水 一征 on 13/09/12.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSLabel.h"
#import "deff.h"
#import <QuartzCore/QuartzCore.h>

@interface KSLabel ()

@property (nonatomic) CGRect    scoreRect;

@end

@implementation KSLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        
        //共通
        self.font = [UIFont fontWithName:APPLI_FONT size:24];
        
        // <layer corner round>
        CALayer    *mLayer = [self layer];
        [mLayer setMasksToBounds:NO];
        [mLayer setCornerRadius:BUTTON_CORNER_ROUND];
        //<layer shadow>
        mLayer.shadowOpacity = 0.4;
        mLayer.shadowOffset  = SHADOW_OFFSET;
        mLayer.shadowColor   = [COLOR_MENU_Charactors CGColor];
        
        self.scoreRect = CGRectMake(MENU_BASE_POSI_X + MENU_width + ADJUST_POSI_X,
                                    MENU_BASE_POSI_Y,
                                    MENU_width,
                                    MENU_height);
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (KSLabel *)yakuSucoreLabel {
    
    KSLabel    *label = [[KSLabel alloc] initWithFrame:self.scoreRect];
    CGRect rect = label.frame;
    rect.origin.x        = SCREEN_SIZE.width;
    label.frame           = rect; // 画面の外に待機
    label.font            = [UIFont fontWithName:APPLI_FONT size:20];
    label.textColor       = [UIColor whiteColor];
    label.backgroundColor = COLOR_red;
    label.textAlignment   = NSTextAlignmentCenter;
    label.text            = @"yaku score";
    label.alpha           = 0;
    
    return label;
}

- (KSLabel *)giveUpLabel {
    KSLabel    *lab = [[KSLabel alloc] initWithFrame:CGRectZero];
    lab.frame = CGRectMake(GIVE_UP_INDICATOR_X_POSI,
                           -1 * GIVE_UP_INDICATOR_height,
                           GIVE_UP_INDICATOR_width,
                           GIVE_UP_INDICATOR_height);
    lab.text            = @"Give Up? Push it";
    lab.backgroundColor = [UIColor clearColor];
    lab.alpha           = 1.0;
    lab.font            = [UIFont fontWithName:APPLI_FONT size:GIVE_UP_INDICATOR_FONT_SIZE];
    lab.textColor       = COLOR_red;
    
    return lab;
}


#define REMAINCARD_LABEL_POSI_X_ADJUST 30
#define REMAINCARD_LABEL_POSI_Y_ADJUST 10

- (KSLabel *)remainCardsLabel {
    KSLabel    *lab = [[KSLabel alloc] initWithFrame:CGRectZero];
    CGRect rRect = self.scoreRect;
    rRect.origin.y = rRect.origin.y - REMAINCARD_LABEL_POSI_Y_ADJUST;
    rRect.origin.x = rRect.origin.x - REMAINCARD_LABEL_POSI_X_ADJUST;
    lab.frame = rRect;
    
    lab.text            = @"100";
    lab.backgroundColor = [UIColor clearColor];
    lab.alpha           = 1.0;
    lab.font            = [UIFont fontWithName:APPLI_FONT size:GIVE_UP_INDICATOR_FONT_SIZE];
    lab.textColor       = COLOR_red;
    lab.textAlignment = NSTextAlignmentCenter;
    
    return lab;
    
}

@end
