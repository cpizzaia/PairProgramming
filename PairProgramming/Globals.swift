//
//  Globals.swift
//  PairProgramming
//
//  Created by Cody Pizzaia on 7/6/18.
//  Copyright © 2018 Stationhead. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

func log(_ message: String, functionName: String = #function, line: Int = #line, fileName: String = #file) {
  let className: String = fileName.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
  let statement = "[MT:\(Thread.isMainThread)] \(className) -> \(functionName)[L:\(line)]: \(message)"

  print(statement)
}

enum SpotifyData {
  static let clientID = "55fd442d38ca4bb8b4a885435ca06bd9"
  static let clientSecret = "0dcc7c42a9894627a224267726ce7339"
}
