//
//  Builder.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

public protocol Buildable {
    associatedtype BuildType
    associatedtype DependencyType
    
    init(dependency: DependencyType)
    func build() -> BuildType
}

open class Builder<BuildType, DependencyType>: Buildable {
    
    public var dependency: DependencyType
    
    required public init(dependency: DependencyType) {
        self.dependency = dependency
    }
    
    open func build() -> BuildType {
        fatalError("Not Implemented")
    }
}
