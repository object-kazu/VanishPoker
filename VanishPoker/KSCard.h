//
//  KSCard.h
//  DragCardTest
//
//  Created by 清水 一征 on 13/07/02.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "deff.h"
#import "KSMasuManager.h"
#import "KSMark.h"

@interface KSCard : UIView

@property (nonatomic) MasuPoint              masu;
@property (nonatomic) NSInteger              cardNumber;
@property (nonatomic, retain) UILabel        *marker;
@property (nonatomic, retain) KSMark         *mark;
@property (nonatomic, retain) UIImageView    *backImg;

- (id)initWithMasu:(MasuPoint)masu;

- (CGPoint)masuToPoint:(MasuPoint)masu;
- (void)cardAt:(MasuPoint)masu;

@end
