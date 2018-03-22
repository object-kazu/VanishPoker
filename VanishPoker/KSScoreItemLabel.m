
//
//  KSScoreItemLabel.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/23.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSScoreItemLabel.h"
#import "deff.h"
#import <QuartzCore/QuartzCore.h>

@implementation KSScoreItemLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.backgroundColor = COLOR_yellow;
        
        CALayer    *mLayer = [self layer];
        [mLayer setMasksToBounds:NO];
        [mLayer setCornerRadius:BUTTON_CORNER_ROUND];
        //<layer shadow>
        mLayer.shadowOpacity = 0.4;
        mLayer.shadowOffset  = SHADOW_OFFSET;
        mLayer.shadowColor   = [COLOR_MENU_Charactors CGColor];
        
#define ITEM_TITLE_X      10
#define ITEM_TITLE_Y      10
        
#define ITEM_TITLE_width  100
#define ITEM_TITLE_height 20

        self.itemTitle       = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemTitle.frame = CGRectMake(ITEM_TITLE_X,
                                          ITEM_TITLE_Y,
                                          ITEM_TITLE_width,
                                          ITEM_TITLE_height);
        
        self.itemTitle.font = [UIFont fontWithName:APPLI_FONT size:12];
        self.itemTitle.textAlignment = NSTextAlignmentLeft;
        self.itemTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:self.itemTitle];

        
#define ITEM_VALUE_width 120
#define ITEM_VALUE_height 20
        
        self.itemValue       = [[UILabel alloc] initWithFrame:CGRectZero];
        self.itemValue.frame = CGRectMake(ITEM_VALUE_width,
                                          ITEM_TITLE_Y,
                                          ITEM_VALUE_width,
                                          ITEM_VALUE_height);
        
        self.itemValue.font = [UIFont fontWithName:APPLI_FONT size:12];
        self.itemValue.textAlignment = NSTextAlignmentRight;
        self.itemValue.backgroundColor = [UIColor clearColor];
        [self addSubview:self.itemValue];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}



@end
