//
//  KSDiviceHelper.m
//  CardOperationTest
//
//  Created by 清水 一征 on 13/08/16.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import "KSDiviceHelper.h"

@implementation KSDiviceHelper


+ (BOOL)isPhone
{
    static BOOL isPhone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
    });
    return isPhone;
}

+ (BOOL)isRetina
{
    static BOOL isRetina;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isRetina = [UIScreen mainScreen].scale == 2.f;
    });
    return isRetina;
}

+ (BOOL)is568h
{
    static BOOL is568h;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        is568h = height == 568.f;
    });
    return is568h;
}

+ (BOOL)isJapaneseLanguage
{
    static BOOL isJapanese;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        isJapanese = [currentLanguage isEqualToString:@"ja"];
    });
    return isJapanese;
}

@end
