//
//  KSDataFormatter.h
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/18.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSDataFormatter : NSObject

- (NSString *)displayDateFormatted:(NSDate *)date;

// score formatte
-(NSString*) scoreFormatted:(NSInteger)score;


- (NSDateComponents *)separateDateComponets:(NSDate *)date;
@end
