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

import LKJsApiExternal
import LKKABridge
import MapKit
import NativeAppPublicKit

/// An implementation of protocol `KANativeAppPluginDelegate`
@objc
public class JsApiImplLocation: NSObject {
    private let locationManager = LocationManager()
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()

    var callback: ((Bool, [String: Any]?) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }

    func startTracking() {
        manager.startUpdatingLocation()
    }

    func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> Void) {
        geocoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            geocode(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { placemark, error in
                guard let place = placemark, error == nil else {
                    self.callback?(false, nil)
                    return
                }

                var addr = place.country ?? ""
                addr += place.administrativeArea ?? ""
                addr += place.locality ?? ""
                addr += place.thoroughfare ?? ""
                addr += place.subThoroughfare ?? ""

                let dic: [String: Any] = [
                    "addr": addr,
                    "longitude": location.coordinate.longitude,
                    "latitude": location.coordinate.latitude,
                ]

                DispatchQueue.main.async {
                    self.callback?(true, dic)
                }
            }

            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_: CLLocationManager, didFailWithError _: Error) {
        callback?(false, nil)
    }
}

extension JsApiImplLocation: KANativeAppPluginDelegate {
    /// Return an api event name support by this implementation
    public func getPluginName() -> String {
        ""
    }

    /// Return a list of event names support by this implementation
    public func getPluginApiNames() -> [String] {
        ["GET_LOCATION"]
    }

    /// Event handler
    public func handle(event _: LKJsApiExternal.KANativeAppAPIEvent, callback: @escaping (Bool, [String: Any]?) -> Void) {
        locationManager.callback = callback
        locationManager.startTracking()
    }

    /// Set context
    public func setContext(context _: NativeAppPublicKit.NativeAppPluginContextProtocol) {}
}

/// Registry class
@objcMembers
public class LKJsApiExternalTemplateSwift: NSObject {
    /// Registry method invoked in Object-C  on loading
    public class func swiftLoad(channel: String) {
        let api = KAAPI(channel: channel)
        api.register(nativeAppPluginDelegate: JsApiImplLocation.init, cache: true)
    }
}
