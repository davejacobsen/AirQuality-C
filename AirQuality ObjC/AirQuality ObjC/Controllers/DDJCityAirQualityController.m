//
//  DDJCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by David on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "DDJCityAirQualityController.h"
#import "DDJCityAirQuality.h"

static NSString *const baseURLString = @"https://api.airvisual.com/v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponenet = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";
static NSString *const apiKey = @"1bc245ac-0df4-43d6-8fa6-dbc0c90585c9";


@implementation DDJCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *countryURL = [baseURL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];

     NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
           if (error)
           {
               NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
               completion(nil);
               return;
           }
           
           if (response)
           {
               NSLog(@"%@", response);
           }
           
           if (data)
           {
               NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
               NSDictionary *dataDict = topLevel[@"data"];
               NSMutableArray *countries = [NSMutableArray new];
               for (NSDictionary *countryDict in dataDict)
               {
                   NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
                   [countries addObject:country];
               }
               completion(countries);
           }
       }] resume];
}

    + (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
    {
        
        NSURL *baseURL = [NSURL URLWithString:baseURLString];
        NSURL *statesURL = [baseURL URLByAppendingPathComponent:stateComponenet];
        
        NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
        
        NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
        NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
        
        [queryItems addObject:countryQuery];
        [queryItems addObject:apiKeyQuery];
        
        NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
        
        [urlComponents setQueryItems:queryItems];
        
        NSURL *finalURL = [urlComponents URL];
        
        [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error)
            {
                NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
                completion(nil);
                return;
            }
            
            if (response)
            {
                NSLog(@"%@", response);
            }
            
            if (data)
            {
                NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSDictionary *dataDict = topLevel[@"data"];
                NSMutableArray *states = [NSMutableArray new];
                for (NSDictionary *stateDict in dataDict)
                {
                    NSString *state = stateDict[@"state"];
                    [states addObject:state];
                }
                completion(states);
            }
        }] resume];
    }
    
+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *citiesURL = [baseURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDict = topLevel[@"data"];
            NSMutableArray *cities = [NSMutableArray new];
            for (NSDictionary *cityDict in dataDict)
            {
                NSString *city = cityDict[@"city"];
                [cities addObject:city];
            }
            completion(cities);
        }
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(DDJCityAirQuality * _Nullable))completion
{
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *cityURL = [baseURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDict = topLevel[@"data"];
            
            DDJCityAirQuality *cityAQI = [[DDJCityAirQuality alloc] initWithDictionary:dataDict];
            completion(cityAQI);
        }
    }] resume];
}


@end
