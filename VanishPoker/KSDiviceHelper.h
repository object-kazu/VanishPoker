//
//  KSDiviceHelper.h
//  CardOperationTest
//
//  Created by 清水 一征 on 13/08/16.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSDiviceHelper : UIDevice

// iPhoneか
+ (BOOL)isPhone;

// Retinaディスプレイか
+ (BOOL)isRetina;

// 4inch(iPhone5)か
+ (BOOL)is568h;

// 言語環境が日本語か
+ (BOOL)isJapaneseLanguage;

@end
