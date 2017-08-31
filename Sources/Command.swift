//
//  Command.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 8/31/17.
//
//

import Foundation

public protocol Command {
    init() throws
    func run() throws
}
