//
//  CommandLine+Extras.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 9/28/17.
//

import Foundation

extension CommandLine {
    public static func flag<T:CommandLineArgument>()->[T] {
        var settings = [T]()
        
        while case let option = getopt(CommandLine.argc, CommandLine.unsafeArgv, T.shortOptions), option != -1 {
            let arg = String(UnicodeScalar(CUnsignedChar(option)))
            var value: String? = nil
            if let opt = optarg {
                value = String(cString: opt)
            }
            settings.append(T(arg, value: value))
        }
        return settings
    }
}
