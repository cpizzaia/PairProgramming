//
//  APIClient.swift
//  Stationhead
//
//  Created by Cody Pizzaia on 11/25/16.
//  Copyright © 2016 stationhead. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIClient {
  // MARK: Public Types
  typealias JSONResponse = (JSON) -> Void
  typealias ErrorResponse = (APIError) -> Void

  struct APIError: Error {
    let code: Int
    let body: JSON
  }

  // MARK: Private Types
  private struct RequestParams {
    let url: String
    let method: HTTPMethod
    let body: Parameters
    let encoding: ParameterEncoding
    let headers: HTTPHeaders
    let success: JSONResponse
    let failure: ErrorResponse
  }

  // MARK: Public Methods
  func get(url: String, headers: HTTPHeaders = [:], encoding: ParameterEncoding = JSONEncoding.default, success: @escaping JSONResponse, failure: @escaping ErrorResponse) {
    request(params: .init(
      url: url,
      method: .get,
      body: [:],
      encoding: encoding,
      headers: headers,
      success: success,
      failure: failure
      )
    )
  }

  func post(url: String, body: Parameters = [:], encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders = [:], success: @escaping JSONResponse, failure: @escaping ErrorResponse) {
    request(params: .init(
      url: url,
      method: .post,
      body: body,
      encoding: encoding,
      headers: headers,
      success: success,
      failure: failure
      )
    )
  }

  func delete(url: String, body: Parameters = [:], encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders = [:], success: @escaping JSONResponse, failure: @escaping ErrorResponse) {
    request(params: .init(
      url: url,
      method: .delete,
      body: body,
      encoding: encoding,
      headers: headers,
      success: success,
      failure: failure
      )
    )
  }

  func patch(url: String, body: Parameters = [:], encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders = [:], success: @escaping JSONResponse, failure: @escaping ErrorResponse) {
    request(params: .init(
      url: url,
      method: .patch,
      body: body,
      encoding: encoding,
      headers: headers,
      success: success,
      failure: failure
      )
    )
  }

  func put(url: String, body: Parameters = [:], encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders = [:], success: @escaping JSONResponse, failure: @escaping ErrorResponse) {
    request(params: .init(
      url: url,
      method: .put,
      body: body,
      encoding: encoding,
      headers: headers,
      success: success,
      failure: failure
      )
    )
  }

  // MARK: Private Methods
  private func request(params: RequestParams) {
    log("APIRequest -> \(params.method.rawValue): \(params.url)")

    Alamofire.request(
      params.url,
      method: params.method,
      parameters: params.body,
      encoding: params.encoding,
      headers: params.headers
      ).validate().responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
        self.handle(response: response, params: params)
      }
    )
  }

  private func handle(response: DataResponse<Any>, params: RequestParams) {
    let json: JSON = {
      do {
        return try JSON(data: response.data ?? Data())
      } catch {
        log("Couldnt parse data")
        return JSON()
      }
    }()

    switch response.result {
    case .success:
      log("APIRequest -> SUCCESS: \(params.url)")
      params.success(json)

    case .failure:
      log("APIRequest -> FAILURE: \(params.url), error was: \(json)")
      params.failure(.init(code: response.response?.statusCode ?? 400, body: json))
    }
  }
}
