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

#import "LKJsApiExternalIMP.h"
#import "LKJsApiLocationManager.h"
#import <MapKit/MapKit.h>
#import "LKKABridge/KAAPI.h"

/// An implementation of protocol `KANativeAppPluginDelegate`
@implementation JsApiImplRestaurants
- (instancetype) init{
    self = [super init];
    if (self) {
        _locationManager = [[LocationPOIManager alloc] init];
    }
    return self;
}

/// Return a list of event names support by this implementation
- (NSArray<NSString *> * _Nonnull)getPluginApiNames {
  return @[@"GET_RESTAURANTS"];
}

/// Return an api event name support by this implementation
- (NSString * _Nonnull)getPluginName {
  return @"";
}

/// Event handler
- (void)handleWithEvent:(KANativeAppAPIEvent * _Nonnull)event callback:(void (^ _Nonnull)(BOOL, NSDictionary<NSString *,id> * _Nullable))callback {
    self.locationManager.callback = callback;
    [self.locationManager startTracking];
}

/// Set context
- (void)setContextWithContext:(id<NativeAppPluginContextProtocol> _Nonnull)context {
  
}
@end

/// Registry class
@implementation LKJsApiExternalTemplateOC

/// Registry method
+ (void)ocLoadWithChannel:(NSString *)channel {
    KAAPI *api = [[KAAPI alloc] initWithChannel:channel];
    [api registerWithNativeAppPluginDelegate:^id<KANativeAppPluginDelegate>{
        return [[JsApiImplRestaurants alloc] init];
    } cache:YES];
}

@end


