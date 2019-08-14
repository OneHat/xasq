//
//  UserStepManager.m
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserStepManager.h"

#import <HealthKit/HealthKit.h>

@interface UserStepManager ()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

typedef NS_ENUM(NSInteger, StepCountDateType) {
    StepCountDateToday,//今天
    StepCountDateYesterday//昨天
};

@implementation UserStepManager

+ (instancetype)manager {
    static UserStepManager *stepManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stepManager = [[UserStepManager alloc] init];
    });
    
    return stepManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.healthStore = [[HKHealthStore alloc] init];
    }
    return self;
}

#pragma mark -
- (void)requestAuthorizationCompletion:(void (^)(void))completion {
    
    if ([HKHealthStore isHealthDataAvailable]) {
        //不可用
        return;
    }
    
    HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    
    if (status == HKAuthorizationStatusSharingAuthorized) {
        //已经授权
        if (completion) {
            completion();
        }
        
    } else if (status == HKAuthorizationStatusNotDetermined) {
        //不确定
        HKObjectType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        [self.healthStore requestAuthorizationToShareTypes:nil
                                                 readTypes:[NSSet setWithObject:stepCountType]
                                                completion:^(BOOL success, NSError * _Nullable error) {
                                                    if (success && completion) {
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            completion();
                                                        });
                                                    }
                                                }];
    } else if (status == HKAuthorizationStatusSharingDenied) {
        //已经拒绝
    }
}


- (void)getTodayStepsCompletion:(GetUserStepBlock)completion {
    [self getUserStepsWithType:StepCountDateToday completion:completion];
}

- (void)getYesterdayStepsCompletion:(GetUserStepBlock)completion {
    [self getUserStepsWithType:StepCountDateYesterday completion:completion];
}

#pragma mark -
- (void)getUserStepsWithType:(StepCountDateType)type completion:(GetUserStepBlock)completion {
    
    [self requestAuthorizationCompletion:^{
        
        HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierStartDate ascending:NO];
        NSPredicate *predicate = [self predicateForSamplesWithType:type];
        
        HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepType predicate:predicate limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
            if (!error) {
                
                double total = 0;
                
                for(HKQuantitySample *quantitySample in results) {
                    HKQuantity *quantity = quantitySample.quantity;
                    HKUnit *heightUnit = [HKUnit countUnit];
                    double usersHeight = [quantity doubleValueForUnit:heightUnit];
                    
                    total += usersHeight;
                }
                
                completion(total);
            }
        }];
        
        [self.healthStore executeQuery:query];
        
    }];
    
}

- (NSPredicate *)predicateForSamplesWithType:(StepCountDateType)dateType {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate;
    NSDate *endDate;
    
    if (dateType == StepCountDateToday) {
        //今天
        startDate = [calendar dateFromComponents:components];//今天00:00
        endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
        
    } else if (dateType == StepCountDateYesterday) {
        //昨天
        endDate = [calendar dateFromComponents:components];//今天00:00
        startDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:endDate options:0];
    }
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    
    return predicate;
}

@end
