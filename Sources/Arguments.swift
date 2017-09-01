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
    
    enum Status {
        case single
        case double
        case none
        
        init(_ arg: String) {
            switch true {
            case arg.singleDash:
                self = .single
            case arg.doubleDash:
                self = .double
            default:
                self = .none
            }
        }
    }
    
    let arguments: [String]
    var args: [Argument]
    var active = [Argument]()
    var nonexistant = [String]()
    
    public init(_ args: ArgumentList, arguments: [String] = CommandLine.arguments) {
        self.args = args.arguments
        self.arguments = arguments
        prepareArguments()
    }
    
    private func prepareArguments() {
        let total = args.count
        if total > 1 {
            var index = 1
            while index < total {
                switch Status(arguments[index]) {
                case .single:
                    break
                case .double:
                    break
                case .none:
                    break
                }
                
                index += 1
            }
        }
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
