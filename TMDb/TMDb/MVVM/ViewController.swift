//
//  ViewController.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import UIKit

public protocol ViewControllable {
    var uiViewController: UIViewController { get }
    func attachChild(viewControllable: ViewControllable)
    func detachChild(viewControllable: ViewControllable)
    var closeListener: CloseListener? { get set }
}

public protocol CloseListener: class {
    func wasClosed()
}

extension ViewControllable {
    public func attachChild(viewControllable: ViewControllable) {
        uiViewController.addChild(viewControllable.uiViewController)
        uiViewController.view.addSubview(viewControllable.uiViewController.view)
    }
    
    public func detachChild(viewControllable: ViewControllable) {
        viewControllable.uiViewController.removeFromParent()
    }
}

open class ViewController: UIViewController, ViewControllable {
    
    public weak var closeListener: CloseListener?
    
    public var uiViewController: UIViewController {
        return self
    }
    
    public init() {
        // 0TODO: - Use NibReusable
        let nibIdentifier = String(describing: type(of: self))
        if let _ = Bundle.main.path(forResource: nibIdentifier, ofType: "nib") {
            super.init(nibName: nibIdentifier, bundle: nil)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if viewControllerWasClosed() {
            closeListener?.wasClosed()
        }
    }
    
    private func viewControllerWasClosed() -> Bool {
        var wasClosed: Bool = false
        
        if let nav = navigationController, nav.isBeingDismissed || nav.isMovingFromParent {
            wasClosed = true
        } else if isMovingFromParent || isBeingDismissed {
            wasClosed = true
        }
        
        return wasClosed
    }
}
