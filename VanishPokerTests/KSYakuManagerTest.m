//
//  KSYakuManagerTest.m
//  VanishPoker
//
//  Created by 清水 一征 on 13/09/14.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSYakuManagerTest.h"

@implementation KSYakuManagerTest

- (void)setUp
{
    [super setUp];
    self.yManager = [KSYakuManager new];
    
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    self.yManager = nil;
    [super tearDown];
}


-(void) test_isFourCards{
    STAssertFalse([self.yManager isFourCard:3], nil);
    STAssertTrue([self.yManager isFourCard:4], nil);
    STAssertFalse([self.yManager isFourCard:5], nil);
}

-(void) test_isRed{
    KSMark* mark = [KSMark new];
    mark.color = _RED_;
    STAssertTrue([self.yManager isRed:mark],nil);
}


-(void) test_isBlue{
    KSMark* mark = [KSMark new];
    mark.color = _BLUE_;
    STAssertTrue([self.yManager isBlue:mark],nil);
    
}

-(void) test_isYellow{
    KSMark* mark = [KSMark new];
    mark.color = _YELLOW_;
    STAssertTrue([self.yManager isYellow:mark],nil);
    
}

-(void) test_isGreen{
    KSMark* mark = [KSMark new];
    mark.color = _GREEN_;
    STAssertTrue([self.yManager isGreen:mark],nil);
    
}

-(void) test_bitte{
    
#define FLAG_RED 1
#define FLAG_BLUE 2
#define FLAG_YELLOW 4
#define FLAG_GREEN 8

//    uint16_t test;

    

}

@end
