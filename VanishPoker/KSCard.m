//
//  KSCard.m
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/02.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSCard.h"

@implementation KSCard

#pragma mark -
#pragma mark ---------- property ----------
- (MasuPoint)masu {
    CGPoint      p = self.frame.origin;
    
    MasuPoint    mp = [[KSMasuManager sharedManager] pointToMasu:p];
    
    return mp;
}

- (id)init {
    
    return self;
}

#define MARKER_width  30
#define MARKER_height 30

- (id)initWithMasu:(MasuPoint)masu {
    if ( self = [super init] ) {
        CGPoint    p = [self masuToPoint:masu];
        self.frame                  = CGRectMake(p.x, p.y, CARD_WIDTH, CARD_HIGHT);
        self.userInteractionEnabled = YES;
        self.hidden                 = NO;
        
        self.backImg       = [UIImageView new];
        self.backImg.frame = CGRectMake(0,
                                        0,
                                        self.frame.size.width,
                                        self.frame.size.height);
        self.backImg.userInteractionEnabled = YES;
        [self addSubview:self.backImg];
        
        self.marker        = [UILabel new];
        self.marker.frame  = CGRectMake(0, 0, MARKER_width, MARKER_height);
        self.marker.center = CGPointMake(self.frame.size.width * 0.5,
                                         self.frame.size.height * 0.5);
        
        self.marker.backgroundColor = [UIColor clearColor];
        self.marker.font            = [UIFont fontWithName:APPLI_FONT size:CARD_MARK_FONT_SIZE];
        self.marker.textAlignment   = NSTextAlignmentCenter;
        
        self.mark.color  = _BLACK_;
        self.mark.number = 0;
        
        [self addSubview:_marker];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        // Initialization code
    }
    
    return self;
}

- (CGPoint)masuToPoint:(MasuPoint)masu {
    CGFloat    x =  MARGIN_X + CARD_WIDTH * masu.x;
    CGFloat    y = CARD_HIGHT + CARD_HIGHT * masu.y;

    CGPoint    p = CGPointMake(x, y);
    
    return p;
}

- (void)cardAt:(MasuPoint)masu {
    CGPoint    p = [self masuToPoint:masu];
    self.frame = CGRectMake(p.x, p.y, CARD_WIDTH, CARD_HIGHT);
}

@end
