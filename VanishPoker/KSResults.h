//
//  KSResults.h
//  VanishPoker
//
//  Created by 清水 一征 on 13/09/19.
//  Copyright (c) 2013年 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KSResults : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSString * playTime;
@property (nonatomic, retain) NSString * remainCards;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * times_F;
@property (nonatomic, retain) NSString * times_LSF;
@property (nonatomic, retain) NSString * times_P;
@property (nonatomic, retain) NSString * times_PF;
@property (nonatomic, retain) NSString * times_S;
@property (nonatomic, retain) NSString * times_SF;
@property (nonatomic, retain) NSString * times_Four;

@end
