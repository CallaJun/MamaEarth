//
//  ViewController.m
//  MamaEarth
//
//  Created by Calla on 6/18/14.
//  Copyright (c) 2014 Calla. All rights reserved.
//

#import "ViewController.h"
#import "GetWeather.h"

@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController
BOOL weatherCalled = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getWeather:(CLLocation *)location {
    if (weatherCalled == 0) {
        CLLocationCoordinate2D currentLocation = location.coordinate;
        NSLog(@"%f, %f", currentLocation.latitude, currentLocation.longitude);
        GetWeather *weather = [[GetWeather alloc] init];
        [weather getWeatherAtCurrentLocation:currentLocation];
        self.currentLocation.text = weather.currentLocation;
        self.currentTemp.text = weather.currentTemperature;
        
        NSDate *today = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterNoStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
        self.lastRetrieved.text = [formatter stringFromDate:today];
        weatherCalled = 0;
    } else {
        NSLog(@"Weather Check Already in Progress");
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = [locations lastObject];
    [self getWeather:location];
    weatherCalled = 1;
}
- (IBAction)refreshTemp:(UIButton *)sender {
    weatherCalled = 0;
    [self.locationManager startUpdatingLocation];
}
@end
