//
//  Commandable.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 3/7/18.
//

import Foundation

public protocol Commandable {
    var hashValue: Int { get }
    var short: String { get }
    var hasArgument: Bool { get }
}
