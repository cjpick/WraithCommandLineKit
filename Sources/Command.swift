//
//  Command.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 8/31/17.
//
//

import Foundation

public protocol Command {
    init(_ arguments: [String]) throws
    func run() throws
}
