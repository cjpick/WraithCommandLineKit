//
//  Arguments.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 8/31/17.
//
//

import Foundation

public protocol ArgumentList {
    var arguments: [Argument] { get }
}

public class Arguments {
    
    enum ArgumentError: Error {
        case noHook(String)
        case noParameter(String)
    }
    
    enum ArgumentType {
        case single(String)
        case multiple(String)
        case parameter(String)
        
        init(_ arg: String) {
            switch true {
            case arg.noDash:
                self = .parameter(arg)
            case arg.doubleDash:
                self = .single(arg.stripDash())
            default:
                if arg.characters.count > 2 {
                    self = .multiple(arg.stripDash())
                } else {
                    self = .single(arg.stripDash())
                }
            }
        }
        
        var parameter: String? {
            switch self {
            case .parameter(let value):
                return value
            default:
                return nil
            }
        }
    }
    
    let arguments: [ArgumentType]
    var args: [Argument]
    var active = [Argument]()
    var errors = [ArgumentError]()
    
    public init(_ args: ArgumentList, arguments: [String] = CommandLine.arguments) {
        self.args = args.arguments
        self.arguments = arguments.map{ return ArgumentType($0) }
        prepareArguments()
    }
    
    private func prepareArguments() {
        guard arguments.count > 1 else {
            return
        }
        let total = arguments.count
        if total >= 1 {
            var index = 1
            while index < total {
                switch arguments[index] {
                case .single(let value):
                    index += prepare(value, parameter: following(index)) ? 1 : 0
                case .multiple(let value):
                    let _ = prepare(value, parameter: nil)
                case .parameter(let value):
                    let _ = prepare("", parameter: value)
                }
                index += 1
            }
        }
    }
    
    private func prepare(_ argString: String, parameter: String?) -> Bool {
        let found = args.filter{ return $0.hook.index(of: argString) != nil }
        if let arg = found.first {
            switch (arg.parameterStatus, parameter != nil) {
            case (.none, _):
                args.append(arg)
                return false
            case (_, true):
                arg.setParameter(parameter ?? "")
                args.append(arg)
            case (.optional, false):
                args.append(arg)
            case (.required, false):
                errors.append(.noParameter(argString))
            default:
                print("Should not reach here. Arg: \(argString), Parameter: \(parameter ?? "None")")
            }
        } else {
            errors.append(.noHook(argString))
        }
        return false
    }
    
    private func following(_ index: Int)->String? {
        guard index+1 < arguments.count else {
            return nil
        }
        return arguments[index+1].parameter
    }
}


extension String {
    
    var noDash: Bool {
        if characters.count > 0 {
            return characters.first != "-"
        }
        return true
    }
    
    var singleDash: Bool {
        if characters.count > 1 {
            return characters.first == "-" && characters[characters.index(after: characters.startIndex)] != "-"
        }
        return false
    }
    
    var doubleDash: Bool {
        if characters.count > 2 {
            return characters.first == "-" && characters[characters.index(after: characters.startIndex)] == "-"
        }
        return false
    }
    
    func stripFirst()->String {
        return substring(from: characters.index(after: characters.startIndex))
    }
    
    func stripDash()->String {
        switch true {
        case doubleDash:
            return stripFirst().stripFirst()
        case singleDash:
            return stripFirst()
        default:
            return self
        }
        
    }
    
}
