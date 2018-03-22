//
//  KSMasu.h
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/08.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "deff.h"

@interface KSMasu : UIView

@property(nonatomic) BOOL isCardOn;
@property(nonatomic) CGPoint centerOfMasu;
@property(nonatomic) MasuPoint masuPoint;

-(id) initWithPosition:(CGFloat)x y:(CGFloat)y;

@end
