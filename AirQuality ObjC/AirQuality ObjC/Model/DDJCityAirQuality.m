//
//  DDJCityAirQuality.m
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DDJCityAirQuality.h"
#import "DDJWeather.h"
#import "DDJPollution.h"

@implementation DDJCityAirQuality

- (instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                     weather:(DDJWeather *)weather
                   pollution:(DDJPollution *)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}

@end

@implementation DDJCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    
    DDJWeather *weather = [[DDJWeather alloc] initWithDictionary:currentInfo[@"weather"]];
        DDJPollution *pollution = [[DDJPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
   
        return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
    }

@end
