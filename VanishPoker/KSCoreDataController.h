//  template
//  KSDietController.h
//  LastSupper
//
//  Created by 清水 一征 on 12/10/28.
//  Copyright (c) 2012年 momiji-mac.com. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "KSResults.h"
#import "deff.h"

@interface KSCoreDataController : NSObject
{
    NSManagedObjectContext    *_managedObjectContext;
}

// プロパティ
@property (nonatomic, readonly) NSManagedObjectContext    *managedObjectContext;


// 初期化
+ (KSCoreDataController *)sharedManager;

// アイテムの操作
- (KSResults *)insertNewEntity;
- (NSArray *)sortedEntity:(BOOL)fromOld_toNew;
- (NSArray *)sortedEntityByScore;

// 永続化
- (void)save;

@end
