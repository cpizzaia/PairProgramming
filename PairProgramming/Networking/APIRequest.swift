//
//  APIRequest.swift
//  Stationhead
//
//  Created by Cody Pizzaia on 11/25/16.
//  Copyright © 2016 stationhead. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIRequest {

  struct APIError: Error {
    let code: Int
    let domainCode: Int?
    let errorDescription: String
    let validationDetails: String?
    let userTitle: String?
    let userMessage: String?

    var title: String {
      get {return userTitle ?? "Error"}
    }

    var description: String {
      get {return userMessage ?? validationDetails ?? errorDescription}
    }

    init(code: Int, domainCode: Int? = nil, description: String, validationDetails: String? = nil, userTitle: String? = nil, userMessage: String? = nil) {
      self.code = code
      self.domainCode = domainCode
      self.errorDescription = description
      self.validationDetails = validationDetails
      self.userTitle = userTitle
      self.userMessage = userMessage
    }
  }

  struct Response {
    let statusCode: Int
    let headers: Headers
    let body: Body
  }

  typealias Headers = JSON
  typealias Body = JSON

  struct RequestParams {
    let url: String
    let method: HTTPMethod
    let body: Parameters?
    let headers: HTTPHeaders?
    let success: JSONResponse
    let failure: JSONResponse
  }

  typealias JSONResponse = (JSON) -> Void

  func get(url: String, headers: HTTPHeaders?, success: @escaping JSONResponse, failure: @escaping JSONResponse) {

    request(params: RequestParams(url: url, method: .get, body: nil, headers: headers, success: success, failure: failure))

  }

  func post(url: String, body: Parameters?, headers: HTTPHeaders?, success: @escaping JSONResponse, failure: @escaping JSONResponse) {

    request(params: RequestParams(url: url, method: .post, body: body, headers: headers, success: success, failure: failure))

  }

  func delete(url: String, body: Parameters?, headers: HTTPHeaders?, success: @escaping JSONResponse, failure: @escaping JSONResponse) {

    request(params: RequestParams(url: url, method: .delete, body: body, headers: headers, success: success, failure: failure))

  }

  func patch(url: String, body: Parameters?, headers: HTTPHeaders?, success: @escaping JSONResponse, failure: @escaping JSONResponse) {

    request(params: RequestParams(url: url, method: .patch, body: body, headers: headers, success: success, failure: failure))

  }

  func put(url: String, body: Parameters?, headers: HTTPHeaders?, success: @escaping JSONResponse, failure: @escaping JSONResponse) {

    request(params: RequestParams(url: url, method: .put, body: body, headers: headers, success: success, failure: failure))

  }

  private func request(params: RequestParams) {
    log("APIRequest -> \(params.method.rawValue): \(params.url)")

    Alamofire.request(
      params.url,
      method: params.method,
      parameters: params.body,
      encoding: JSONEncoding.default,
      headers: params.headers
      ).validate().responseJSON(queue: DispatchQueue.global(), completionHandler: { response in
        self.handle(response: response, params: params)
      })

  }

  // MARK: Private Methods
  private func handle(response: DataResponse<Any>, params: RequestParams) {

    let json: JSON

    do {
      json = try JSON(data: response.data ?? Data())
    } catch {
      log("Couldnt parse data")
      json = JSON()
    }

    let apiResponse = Response(
      statusCode: response.response?.statusCode ?? 400,
      headers: JSON(response.response?.allHeaderFields ?? [:]),
      body: json
    )

    switch response.result {
    case .success:
      log("APIRequest -> SUCCESS: \(params.url)")
      params.success(apiResponse.body)

    case .failure:
      log("APIRequest -> FAILURE: \(params.url)")
      params.failure(apiResponse.body)
    }
  }
}
