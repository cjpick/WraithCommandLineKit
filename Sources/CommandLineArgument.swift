//
//  CommandLineArgument.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 9/28/17.
//

import Foundation

public protocol CommandLineArgument {
    static var shortOptions: String { get }
    init(_ arg: String, value: String?)
}
