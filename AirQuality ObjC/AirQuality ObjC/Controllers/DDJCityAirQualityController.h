//
//  DDJCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDJCityAirQuality;


NS_ASSUME_NONNULL_BEGIN

@interface DDJCityAirQualityController : NSObject

+(void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedStatesInCountry:(NSString *)country
                          completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchSupportedCitiesInState:(NSString *)state
                           country:(NSString *)country
                        completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

+(void)fetchDataForCity:(NSString *)city
                  state:(NSString *)state
                country:(NSString *)country
             completion:(void (^) (DDJCityAirQuality *_Nullable))compleiton;

@end

NS_ASSUME_NONNULL_END
