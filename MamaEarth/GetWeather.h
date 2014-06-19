//
//  GetWeather.h
//  MamaEarth
//
//  Created by Calla on 6/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GetWeather : NSObject
@property (strong, nonatomic) NSString *currentLocation;
@property (strong, nonatomic) NSString *currentTemperature;

- (void)getWeatherAtCurrentLocation:(CLLocationCoordinate2D)coordinate;
@end
