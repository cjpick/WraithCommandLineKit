//
//  Argument.swift
//  WraithCommandLineKit
//
//  Created by Christopher Pick on 8/31/17.
//
//

import Foundation

public enum ArgumentParameterStatus {
    case none
    case optional
    case required
}

public protocol Argument: CustomStringConvertible {
    
    var hook: [String] { get }
    var definition: String { get }
    
    init?(hook: String?, definition: String?, defaultParameter:String?)
    
    var parameterStatus: ArgumentParameterStatus { get }
    func setParameter(_ value: String)
}

extension Argument {
    
    var description: String {
        return "  \(hook.map({ return $0.characters.count > 1 ? "--"+$0 : "-"+$0}).joined(separator: ", ")) - \(definition)"
    }
}
