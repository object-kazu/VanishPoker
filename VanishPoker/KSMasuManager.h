//
//  KSMasuManager.h
//  CardOperationTest
//
//  Created by 清水 一征 on 13/07/10.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSMasu.h"
#import "deff.h"

@interface KSMasuManager : NSObject

+(KSMasuManager*) sharedManager;

// for device
@property (nonatomic) NSInteger intersection_y;
@property (nonatomic) NSInteger masuMax_y;

#pragma mark -
#pragma mark ---------- Masu Array ----------
//masuArray作成
@property(nonatomic,readonly) NSArray* xPointArray;
@property(nonatomic,readonly) NSArray* yPointArray;
@property (nonatomic,retain) NSMutableArray* masuArray;
@property (nonatomic,retain) NSMutableArray* emptyMasuArray;// Cardが載っていないマスの配列
-(void) makeMasues;


#pragma mark -
#pragma mark ---------- 座標／Masu変換 ----------
// CGPointを指定するとMasuを特定する
-(MasuPoint) pointToMasu:(CGPoint)point;

// Masuを指定するとCGpointに変換
-(CGPoint) masuToPoint:(MasuPoint) masu;


#pragma mark -
#pragma mark ---------- マス操作 ----------
// 指定の１つ上のマスを取得
-(MasuPoint) masuAbove:(MasuPoint) masu;
// 指定の１つ下のマスを取得
-(MasuPoint) masuUnder:(MasuPoint) masu;
// 指定の１つ右のマスを取得
-(MasuPoint) masuLeft:(MasuPoint) masu;
// 指定の１つ左のマスを取得
-(MasuPoint) masuRight:(MasuPoint) masu;


#pragma mark -
#pragma mark ---------- touch ----------
//touch point によるMasuに処理(isCardOn = YES)
-(void) didMasuTouchedAt:(CGPoint) point;


#pragma mark -
#pragma mark ---------- isCardOn ----------

-(void) isCardOnInit; //すべてのMasuのisCardOn をYESに

@end
