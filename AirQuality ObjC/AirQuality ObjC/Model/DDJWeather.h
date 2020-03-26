//
//  DDJWeather.h
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDJWeather : NSObject

@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;

-(instancetype)initWithWeatherInfo:(NSInteger)temperature
                          humidity:(NSInteger)humidity
                         windSpeed:(NSInteger)windSpeed;

@end

@interface DDJWeather (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
