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

import Foundation

struct PasswordVerify {
    typealias LandURL = String

    enum PasswordError: Error {
        case wrongRequestURL
        case invalidResponseOrData
        case requestError(error: Error)
    }

    private let clientID = "YOUR_APP_ID"
    private let domain = "YOUR_LOGIN_URL"

    func url(state: String) throws -> URL {
        guard let url = URL(string: "\(domain)?client_id=\(clientID)&state=\(state)") else {
            throw PasswordError.wrongRequestURL
        }
        return url
    }

    func checkPassword(phone: String, password: String, state: String, callback: @escaping (Result<LandURL, PasswordError>) -> Void) {
        do {
            let requsetURL = try url(state: state)
            var request = URLRequest(url: requsetURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = try JSONSerialization.data(withJSONObject: ["username": phone, "password": password], options: [])
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    callback(.failure(.requestError(error: error)))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data else {
                    callback(.failure(.invalidResponseOrData))
                    return
                }

                guard let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                      let landUrl = ((json["data"] as? [String: Any])?["step_info"] as? [String: Any])?["land_url"] as? String
                else {
                    callback(.failure(.invalidResponseOrData))
                    return
                }
                callback(.success(landUrl))
            }
            task.resume()
        } catch {
            let error: PasswordError = (error as? PasswordError) ?? PasswordError.requestError(error: error)
            callback(.failure(error))
        }
    }
}
