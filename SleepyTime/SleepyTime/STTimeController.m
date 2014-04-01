//
//  STTimeController.m
//  SleepyTime
//
//  Created by Peter  Blanco on 4/1/14.
//  Copyright (c) 2014 Blancotech. All rights reserved.
//

#import "STTimeController.h"
#import "STTimeModel.h"

NSTimeInterval ONESLEEPCYLCETIME = 60*90;
NSTimeInterval FALLASLEEPTIME = 60*14;

@interface STTimeController ()
- (NSString *)getStringForTime:(NSDate *)date;
- (NSString *)getStringHourForStartTime:(NSDate *)startDate toEndtime:(NSDate *)endDate;
@end

@implementation STTimeController

- (NSArray *)getWakeupTimesFor:(NSDate *)date
{
    NSMutableArray *timesArray = [[NSMutableArray alloc]init];
    
    //Add initial time
    NSTimeInterval startingTimeInterval = ONESLEEPCYLCETIME + FALLASLEEPTIME;
    NSDate *startTimeDate = [date dateByAddingTimeInterval:startingTimeInterval];
    
    //Create temp strings
    NSString *tmpTime = [self getStringForTime:startTimeDate];
    NSString *tmpHours = [self getStringHourForStartTime:date toEndtime:startTimeDate];
    
    //create object and add to array
    [timesArray addObject:[[STTimeModel alloc] initWithTime:tmpTime andHoursOfSleep:tmpHours]];
    
    //add the rest of the times
    NSDate *tempDate = startTimeDate;
    for (int i = 1; i <6; i++) {
        //increment date by 90 mins
        tempDate = [tempDate dateByAddingTimeInterval:ONESLEEPCYLCETIME];
        
        NSString *tmpTime = [self getStringForTime:tempDate];
        NSString *tmpHours = [self getStringHourForStartTime:date toEndtime:tempDate];
        
        STTimeModel *tmpTimeModel = [[STTimeModel alloc] initWithTime:tmpTime andHoursOfSleep:tmpHours];
        [timesArray addObject:tmpTimeModel];
    }
    NSLog(@"Dates: \n %@", timesArray);
    return [NSArray arrayWithArray:timesArray];
}

- (NSArray *)getSleepTimesFor:(NSDate *)date
{
//TODO: Implement me!
  
    return [[NSArray alloc]init];
}

//Helper methods
-(NSString *)getStringForTime:(NSDate *)date
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm ha"];
    NSString *time = [timeFormatter stringFromDate:date];
    return time;
}

-(NSString *)getStringHourForStartTime:(NSDate *)startDate toEndtime:(NSDate *)endDate {
    NSTimeInterval distanceBetweenDates = [startDate timeIntervalSinceDate:endDate];
    double secondsInAnHour = 3600; // (60sec * 60mins)
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    return [NSString stringWithFormat:@"%i hs",hoursBetweenDates];
}




@end







