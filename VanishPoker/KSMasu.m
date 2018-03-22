//
//  KSMasu.m
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/08.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSMasu.h"

@implementation KSMasu

- (id)init {
    self = [self initWithPosition:0 y:0];
    
    return self;
}

- (id)initWithPosition:(CGFloat)x y:(CGFloat)y {
    if ( self = [super init] ) {
        self.frame                  =  CGRectMake(x, y, CARD_WIDTH, CARD_HIGHT);
        self.userInteractionEnabled = NO;
        self.hidden                 = YES;
        _centerOfMasu               = CGPointMake(x + CARD_WIDTH * 0.5, y + CARD_HIGHT * 0.5);
        
    }
    
    return self;
    
}

- (MasuPoint)masuPoint {
    
    MasuPoint    p;
    p.x = (self.frame.origin.x - MARGIN_X) / CARD_WIDTH;
    p.y = (self.frame.origin.y - CARD_HIGHT) / CARD_HIGHT;
    
    return p;
}

@end
