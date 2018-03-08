//
//  CommandLine+Extras.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 9/28/17.
//

import Foundation

extension CommandLine {
    
    public static func flag(_ arguments: CommandLineArgument)->CommandLineArgument {
        while case let option = getopt(CommandLine.argc, CommandLine.unsafeArgv, arguments.shortOptions), option != -1 {
            let arg = String(UnicodeScalar(CUnsignedChar(option)))
            var value: String? = nil
            if let opt = optarg {
                value = String(cString: opt)
            }
            arguments.add(arg, value: value)
        }
        return arguments
    }
    
    public static func printShell(_ launchPath: String, arguments: [String] = []) {
        let output = shell(launchPath, arguments:arguments)
        
        if (output != nil) {
            print(output!)
        }
    }
    
    public static func shell(_ launchPath: String, arguments: [String] = []) -> String? {
        
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String? = String(data: data, encoding: String.Encoding.utf8)
        
        return output
    }
}
