//
//  Globals.swift
//  PairProgramming
//
//  Created by Cody Pizzaia on 7/6/18.
//  Copyright © 2018 Stationhead. All rights reserved.
//

import Foundation

func log(_ message: String, functionName: String = #function, line: Int = #line, fileName: String = #file) {
  let className: String = fileName.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
  let statement = "[MT:\(Thread.isMainThread)] \(className) -> \(functionName)[L:\(line)]: \(message)"

  print(statement)
}
