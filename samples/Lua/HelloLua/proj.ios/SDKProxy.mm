//
//  SDKProxy.m
//  HelloLua
//
//  Created by madgenic on 2017/6/23.
//
//

#import "SDKProxy.h"
#import <CoreLocation/CoreLocation.h>

@interface SDKProxy ()<CLLocationManagerDelegate>
{

}

@property(nonatomic,strong)CLLocationManager*locationManager;
@end
@implementation SDKProxy

static SDKProxy* _instance = nil;

+(instancetype) sharedInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance;
}
-(void)startLocation{

    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}


-(double)latitudeLongitudis:(CLLocation*)origin {
    
    CLLocation* dist = [[[CLLocation alloc] initWithLatitude:[lati doubleValue] longitude:[longit doubleValue]]autorelease];
    //单位为米
    CLLocationDistance metres = [origin distanceFromLocation:dist];
    return metres;
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        //        CLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //        CLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    float latitudeTemp = currentLocation.coordinate.latitude;
    float longitudeTemp = currentLocation.coordinate.longitude;
    NSLog(@"经度:%f,纬度:%f",latitudeTemp,longitudeTemp);
   
    if (_blockLocation) {
        
        _blockLocation(latitudeTemp,longitudeTemp);
    }
    if (_blockResult) {
        
        double distance = [self latitudeLongitudis:currentLocation];
        if (distance > DISTANCE_RANGE) {
            _blockResult(0);
        }else{
           _blockResult(1);
        }
        
    }
    [manager stopUpdatingLocation];
    
}
@end
