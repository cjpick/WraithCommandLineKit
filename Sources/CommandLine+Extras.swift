//
//  CommandLine+Extras.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 9/28/17.
//

import Foundation

extension CommandLine {
    
    public static func flag(_ arguments: inout CommandLineArgument) {
        while case let option = getopt(CommandLine.argc, CommandLine.unsafeArgv, arguments.shortOptions), option != -1 {
            let arg = String(UnicodeScalar(CUnsignedChar(option)))
            var value: String? = nil
            if let opt = optarg {
                value = String(cString: opt)
            }
            arguments.add(arg, value: value)
        }
    }
}
