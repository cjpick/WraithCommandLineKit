//
//  CommandLineArgument.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 9/28/17.
//

import Foundation

public protocol CommandLineArgument {
    var shortOptions: String { get }
    func add(_ arg: String, value: String?)
}
