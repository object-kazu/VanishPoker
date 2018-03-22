//
//  KSDataFormatter.m
//  PuzzlePoker
//
//  Created by 清水 一征 on 13/08/18.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSDataFormatter.h"

@implementation KSDataFormatter


- (NSDateComponents *)separateDateComponets:(NSDate *)date {
    // デフォルトのカレンダーを取得
    NSCalendar          *calendar = [NSCalendar currentCalendar];
    
    // 日時をカレンダーで年月日時分秒に分解する
    NSDateComponents    *dateComps = [calendar components:
                                      NSYearCalendarUnit   |
                                      NSMonthCalendarUnit  |
                                      NSDayCalendarUnit    |
                                      NSHourCalendarUnit   |
                                      NSMinuteCalendarUnit |
                                      NSSecondCalendarUnit
                                                 fromDate:date];
    
    //    NSLog(@"separateDateComponets:%d/%02d/%02d",  dateComps.year, dateComps.month, dateComps.day);
    
    return dateComps;
}


- (NSString *)displayDateFormatted:(NSDate *)date {
    NSDateComponents    *comp = [self separateDateComponets:date];
    
    return [NSString stringWithFormat:@"%d/%02d/%02d", comp.year, comp.month, comp.day];
}


-(NSString*) scoreFormatted:(NSInteger)score{
    // 123,456
    NSNumber *number = @(score);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *string = [formatter stringFromNumber:number];
    return string;
}




@end
