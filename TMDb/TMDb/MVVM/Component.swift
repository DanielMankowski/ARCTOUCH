//
//  Component.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import Foundation

public protocol Dependency {
    associatedtype DependencyType
    
    init (dependency: DependencyType)
}

open class Component<DependencyType>: Dependency {
    
    public let dependency: DependencyType
    var singletons: [ObjectIdentifier: AnyObject] = [:]
    
    public required init(dependency: DependencyType) {
        self.dependency = dependency
    }
    
    // MARK: - private
    public final func shared<SingletonType: AnyObject>(singleton: () -> SingletonType) -> SingletonType {
        let key = ObjectIdentifier(SingletonType.self)
        if let object = singletons[key] as? SingletonType {
            return object
        }
        
        let singletonObject = singleton()
        singletons[key] = singletonObject
        
        return singletonObject
    }
}
