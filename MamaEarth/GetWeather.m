//
//  GetWeather.m
//  MamaEarth
//
//  Created by Calla on 6/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import "GetWeather.h"
#import <CoreLocation/CoreLocation.h>

@implementation GetWeather

static const NSString *WORLD_WEATHER_ONLINE_API_KEY = @"49c22460c0eaaa275b796d5d21c3612f146804f2";

- (void)parseJSONData:(NSData *)data {
    NSError *error;
    NSDictionary *parsedJSONData = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:&error];
    NSDictionary *weather = [parsedJSONData objectForKey:@"data"];
    
    // Nearest Area and setting currentLocation property.
    NSDictionary *nearestArea = [weather objectForKey:@"nearest_area"];
    NSArray *array = [nearestArea valueForKey:@"areaName"];
    NSDictionary *currentLocation = [array objectAtIndex:0];
    NSArray *currentLocationString = [currentLocation valueForKey:@"value"];
    self.currentLocation = currentLocationString.lastObject;
    
    // Getting current temp in degrees C
    NSArray *currentCondition = [weather objectForKey:@"current_condition"];
    NSDictionary *tempDictionary = [currentCondition objectAtIndex:0];
    //NSArray *tempInC = [tempDictionary valueForKey:@"temp_C"]; //Taking away declarationg of tempInC
    
    //Calculating tempInF
    NSInteger value = [[tempDictionary valueForKey:@"temp_C"] intValue];
    NSInteger Fvalue = value*1.8+32;
    _degreesF = Fvalue;
    NSString *tempInF = [NSString stringWithFormat:@"%ld", Fvalue];
    
    //originally NSArray *weatherInC = [currentCondition objectForKey:@"temp_c"];
    NSString *temperature = [NSString stringWithFormat:@"%@", tempInF];
    self.currentTemperature = [temperature stringByAppendingString:@"F"];

}
- (void)getWeatherAtCurrentLocation:(CLLocationCoordinate2D)coordinate {
    NSString *urlString = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v1/weather.ashx?q=%f,%f&format=json&num_of_days=1&includelocation=yes&key=%@", coordinate.latitude, coordinate.longitude, WORLD_WEATHER_ONLINE_API_KEY];
    NSURL *weatherURL = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:weatherURL];
    [self parseJSONData:data];
}

@end
