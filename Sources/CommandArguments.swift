//
//  CommandArguments.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 3/7/18.
//

import Foundation

public enum CommandArgumentsError: Error {
    case argumentDoesNotExist
}

public class CommandArguments {
    
    struct Results {
        let short: String
        var isSelected: Bool
        var value: String?
    }
    
    var shortOptions: String = ""
    var arguments = [Int: Results]()
    var hasErrors: Bool { return errors.count > 0 }
    var errors = [CommandArgumentsError]()
    
    public init(_ commands: [Commandable]) {
        commands.forEach { command in
            var short = command.short
            if command.hasArgument {
                short += ":"
            }
            self.shortOptions += short
            self.arguments[command.hashValue] = Results(short: command.short, isSelected: false, value: nil)
        }
        execute()
    }
    
    func execute() {
        while case let option = getopt(CommandLine.argc, CommandLine.unsafeArgv, shortOptions), option != -1 {
            let arg = String(UnicodeScalar(CUnsignedChar(option)))
            var value: String? = nil
            if let opt = optarg {
                value = String(cString: opt)
            }
            add(arg, value: value)
        }
    }
    
    func add(_ arg:String, value: String?) {
        var found = false
        arguments.forEach { key, result in
            if result.short == arg {
                self.arguments[key] = Results(short: result.short, isSelected: true, value: value)
                found = true
            }
        }
        if !found {
            errors.append(.argumentDoesNotExist)
        }
    }
    
    public func isSelected(_ command: Commandable) -> Bool {
        if let arg = arguments[command.hashValue] {
            return arg.isSelected
        }
        return false
    }
    
    public func value(_ command: Commandable) -> String? {
        if let arg = arguments[command.hashValue] {
            return arg.value
        }
        return nil
    }
}
