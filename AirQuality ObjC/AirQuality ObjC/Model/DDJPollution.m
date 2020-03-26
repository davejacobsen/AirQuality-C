//
//  DDJPollution.m
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DDJPollution.h"

@implementation DDJPollution

- (instancetype)initWithInt:(NSInteger)aqi
{
    self = [super init];
    if (self)
    {
        _airQualityIndex = aqi;
    }
    return self;
}

@end

@implementation DDJPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    
    return [self initWithInt:aqi];
}

@end
