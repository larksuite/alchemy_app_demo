//
//  LKJsApiLocationManager.m
//  LKJsApiExternalIMP
//
//  Created by ByteDance on 2024/6/14.
//
#import "LKJsApiLocationManager.h"
#import <MapKit/MapKit.h>

/*
 * Copyright (c) 2025 Lark Technologies Pte. Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/// Location POI manager
@implementation LocationPOIManager {
    CLLocationManager *_manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestWhenInUseAuthorization];
    }
    return self;
}

/// Start position tracking
- (void)startTracking {
    [_manager startUpdatingLocation];
}

/// Implement 'CLLocationManagerDelegate'. Return a list of restaurants nearby
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    
    if (location) {
        MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
        MKLocalSearchRequest *request = [MKLocalSearchRequest new];
        request.naturalLanguageQuery = @"restaurant";
        request.region = coordinateRegion;
        
        MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
        [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
            if (error && self.callback) {
                self.callback(false, nil);
            }
            NSMutableArray *list = [[NSMutableArray alloc] init];
            for (MKMapItem *item in response.mapItems) {
                NSString *type = @"餐厅";
                if (@available(iOS 13.0, *)) {
                    MKPointOfInterestCategory category = item.pointOfInterestCategory;
                    if (category == MKPointOfInterestCategoryRestaurant) {
                        type = @"餐厅";
                    } else if (category == MKPointOfInterestCategoryCafe) {
                        type = @"咖啡馆";
                    } else if (category == MKPointOfInterestCategoryNightlife) {
                        type = @"酒吧";
                    }
                }
            
                CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:item.placemark.coordinate.latitude longitude:item.placemark.coordinate.longitude];
                int distance = (int)[location distanceFromLocation:destinationLocation];
                
                NSDictionary* restaurant = [[NSDictionary alloc] initWithObjectsAndKeys: item.name, @"name", type, @"type", @(distance), @"distance", nil];
                [list addObject: restaurant];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.callback) {
                    self.callback(true, @{@"restaurants": list});
                }
            });
        }];
        
        [_manager stopUpdatingLocation];
    }
}

/// Implement error callback in 'CLLocationManagerDelegate'
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    /* error log */
    if (self.callback) {
        self.callback(NO, nil);
    }
}

@end
