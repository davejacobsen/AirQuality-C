//
//  DDJCityAirQuality.h
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDJWeather;
@class DDJPollution;

NS_ASSUME_NONNULL_BEGIN

@interface DDJCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString * city;
@property (nonatomic, copy, readonly) NSString * state;
@property (nonatomic, copy, readonly) NSString * country;
@property (nonatomic, copy, readonly) DDJWeather * weather;
@property (nonatomic, copy, readonly) DDJPollution * pollution;

-(instancetype)initWithCity:(NSString *)city
                      state:(NSString *)state
                    country:(NSString *)country
                    weather:(DDJWeather *)weather
                  pollution:(DDJPollution *)pollution;
    
@end

@interface DDJCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
