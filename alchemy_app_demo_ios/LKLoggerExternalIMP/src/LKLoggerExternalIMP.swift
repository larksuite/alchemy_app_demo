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

import LKKABridge
import LKLoggerExternal

/// Log level
public enum LogType {
    /// Level verbose
    case verbose
    /// Level debug
    case debug
    /// Level info
    case info
    /// Level warning
    case warning
    /// Level error
    case error
}

/// A class which provides a singleton to invoke the `KALoggerProtocol` ability
@objcMembers
public class LKLoggerExternalTemplate: NSObject {
    private var kaapi: KAAPI
    private var logger: KALoggerProtocol? {
        kaapi.logger
    }

    /// A singleton to invoke the `KALoggerProtocol` ability
    public static var shared: LKLoggerExternalTemplate?

    init(channel: String) {
        kaapi = KAAPI(channel: channel)
    }

    /// Logs a message at a specific type
    public func log(tag: String = "AlchemyAppDemo", type: LogType = .info, _ msg: String) {
        switch type {
        case .verbose: logger?.verbose(tag: tag, msg)
        case .debug: logger?.debug(tag: tag, msg)
        case .info: logger?.info(tag: tag, msg)
        case .warning: logger?.warning(tag: tag, msg)
        case .error: logger?.error(tag: tag, msg)
        }
    }

    /// Initiliazes the singleton on loading Object-C classes
    public class func swiftLoad(channel: String) {
        shared = LKLoggerExternalTemplate(channel: channel)
    }
}
