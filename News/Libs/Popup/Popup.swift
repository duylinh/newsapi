//
//  Popup.swift
//  CalculatorDot
//
//  Created by Duy Linh Tran on 12/2/19.
//  Copyright © 2019 maplelabs. All rights reserved.
//

import UIKit

//Popup View alignment option
public enum PopupAlign {
    case top
    case center
    case bottom
    case custom
}

//Popup View animation option
public enum PopupAnimation {
    case normal
    case top
    case bottom
    case bottomBounce
    case topBounce
}

//Storybord Info
typealias ViewControllerStoryboardInfo = (name: String, id: String?)

//Association key
//Global variable to produce a unique address as the associated object handle.
private var contentViewKey: UInt8 = 0
private var popupViewKey: UInt8 = 1
private var overlayKey: UInt8 = 2
private var touchDismissKey: UInt8 = 3
private var popupAlignmentKey: UInt8 = 4
private var popupAnimationKey: UInt8 = 5
private var popupSizeKey: UInt8 = 6
private var popupCornerKey: UInt8 = 7
private var popupCustomAlignKey: UInt8 = 8
private var popupStordyboardKey: UInt8 = 9

private enum TimeDelay: CaseIterable {
    case normal
    case top
    case bottom
    case bottomBounce
    case topBounce
    
    var value: TimeInterval {
        switch self {
        case .normal: return 0.2
        case .top: return 0.3
        case .bottom: return 0.3
        case .bottomBounce: return 0.45
        case .topBounce: return 0.5
        }
    }
}

extension UIViewController {
    
    //Overlay Color :- background overlay color for popup
    var overlayColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &overlayKey) as? UIColor
        }
        set{
            var defaultOverlay: UIColor? = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
            if let value = newValue
            {
                defaultOverlay = value
            }
            objc_setAssociatedObject(self, &overlayKey, defaultOverlay, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Touch Dismiss :- dismiss popup view on touch background
    var touchDismiss: Bool? {
        get {
            return objc_getAssociatedObject(self, &touchDismissKey) as? Bool
        }
        set{
            objc_setAssociatedObject(self, &touchDismissKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Popup Align :- Popup alignment options
    var popupAlign: PopupAlign? {
        get {
            return objc_getAssociatedObject(self, &popupAlignmentKey) as? PopupAlign
        }
        set{
            var defaultValue: PopupAlign? = .bottom
            if let value = newValue
            {
                defaultValue = value
            }
            return objc_setAssociatedObject(self, &popupAlignmentKey, defaultValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Popup Animation :- Popup animation options
    var popupAnimation: PopupAnimation? {
        get {
            return objc_getAssociatedObject(self, &popupAnimationKey) as? PopupAnimation
        }
        set{
            var defaultValue: PopupAnimation? = .bottom
            if let value = newValue
            {
                defaultValue = value
            }
            objc_setAssociatedObject(self, &popupAnimationKey, defaultValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Popup Size :- Popup View Width and Height
    var popupSize: CGSize? {
        get {
            return objc_getAssociatedObject(self, &popupSizeKey) as? CGSize
        }
        set{
            var defaultValue: CGSize? = CGSize(width: (mainView.bounds.width/2), height: (mainView.bounds.height/2))
            if let value = newValue
            {
                defaultValue = value
            }
            objc_setAssociatedObject(self, &popupSizeKey, defaultValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Popup Corner :- Corner Radius of popup view
    var popupCorner: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &popupCornerKey) as? CGFloat
        }
        set{
            var defaultValue: CGFloat? = 0
            if let value = newValue
            {
                defaultValue = value
            }
            objc_setAssociatedObject(self, &popupCornerKey, defaultValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Popup custom Align :- Custom origin for popup
    var popupCustomAlign: CGPoint? {
        get {
            return objc_getAssociatedObject(self, &popupCustomAlignKey) as? CGPoint
        }
        set{
            var defaultValue: CGPoint? = CGPoint(x: 0, y: 0)
            if let value = newValue
            {
                defaultValue = value
            }
            objc_setAssociatedObject(self, &popupCustomAlignKey, defaultValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Main View :- popup present in main view
    fileprivate var mainView: UIView {
        var viewController = self
        while let parentViewController = viewController.parent {
            viewController = parentViewController
        }
        return viewController.view
    }
    
    //Background View :- popup backgroundview
    fileprivate var contentView: UIView? {
        get {
            return objc_getAssociatedObject(self, &contentViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &contentViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Popup View :- view which shows popup content
    fileprivate var popupView: UIView? {
        get {
            return objc_getAssociatedObject(self, &popupViewKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &popupViewKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //PopupAnimationType :- Animation type for popup view
    fileprivate var animationType: PopupAnimation? {
        get {
            return objc_getAssociatedObject(self, &popupAnimationKey) as? PopupAnimation
        }
        set {
            objc_setAssociatedObject(self, &popupAnimationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Storyboard Name :- Storyboard name to set popup VC
    fileprivate var storyboardName: String? {
        get {
            return objc_getAssociatedObject(self, &popupStordyboardKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &popupStordyboardKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //Set popup VC
    public func setPopupVC(storyboradID:String, viewControllerID:String) -> UIViewController {
        let controller = UIStoryboard(name: storyboradID, bundle: nil).instantiateViewController(withIdentifier: viewControllerID)
        self.storyboardName = storyboradID
        self.popupView = controller.view
        let childController = addChildViewController(withInfo: (name: self.storyboardName!, id: viewControllerID))
        return childController!
    }
    
    public func setPopupVC(with controller: UIViewController) -> UIViewController {
        self.popupView = controller.view
        let childController = addChildViewController(with: controller)
        return childController!
    }
    
    //Present popup VC
    public func presentPopup(controller: UIViewController?, completion: ((Bool)->())?) {
        guard let controller = controller else {
            return
        }
        
        if self.contentView != nil {
            return
        }
        if storyboardName == nil {
            return
        }
        
        let containerView = UIView(frame: mainView.bounds)
        
        let overlayView = UIView(frame: mainView.bounds)
        if let overlay = controller.overlayColor {
            overlayView.backgroundColor = overlay
        } else {
            overlayView.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
        }
        containerView.addSubview(overlayView)
        
        let dismissButton = UIButton(frame: mainView.bounds)
        containerView.addSubview(dismissButton)
        if controller.touchDismiss ?? true{
            dismissButton.addTarget(self, action: #selector(UIViewController.dismissPopupView), for: UIControl.Event.touchUpInside)
        }
        
        if let cornerRadius = controller.popupCorner {
            popupView?.layer.cornerRadius = cornerRadius
            popupView?.layer.masksToBounds = true
        }
        
        if let popupSize = controller.popupSize {
            popupView?.frame.size = popupSize
        }else{
            popupView?.frame.size = CGSize(width: (mainView.bounds.width/2), height: (mainView.bounds.height/2))
        }
        switch controller.popupAlign ?? .center {
        case .top:
            popupView?.frame.origin = CGPoint(x:(mainView.frame.size.width/2)-((popupView?.bounds.width)!/2), y: 64)
        case .center:
            popupView?.center = CGPoint(x: mainView.frame.size.width/2, y: mainView.frame.size.height/2)
        case .bottom:
            popupView?.frame.origin = CGPoint(x:(mainView.frame.size.width/2)-((popupView?.bounds.width)!/2), y: mainView.frame.height - (popupView?.bounds.height)!)
        case .custom:
            if let customPoint = controller.popupCustomAlign {
                popupView?.frame.origin = customPoint
            }else{
                popupView?.center = CGPoint(x: mainView.frame.size.width/2, y: mainView.frame.size.height/2)
            }
        }
        containerView.addSubview(popupView!)
        mainView.addSubview(containerView)
        self.contentView = containerView
        if let animationType = controller.popupAnimation{
            self.animationType = animationType
            self.setupPresentAnimation(type: animationType)
        } else {
            animationType = .bottom
            self.setupPresentAnimation(type: animationType!)
        }
    }
    
    //Subview the popup view
    fileprivate func addSubview(subView:UIView, toView parentView:UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        
        viewBindingsDict["subView"] = subView
        
        
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        
    }
    
    //Add popup VC as child VC
    fileprivate func addChildViewController(withInfo info: ViewControllerStoryboardInfo)-> UIViewController? {
        
        var viewController: UIViewController! = nil
        
        switch info.id {
        case let identifier where identifier != nil:
            viewController = UIStoryboard(name: info.name, bundle: nil).instantiateViewController(withIdentifier: identifier!)
        default:
            viewController = UIStoryboard(name: info.name, bundle: nil).instantiateInitialViewController()
        }
        
        if let viewController = viewController {
            
            self.addChild(viewController)
            viewController.view.frame = self.view.bounds
            self.addSubview(subView: viewController.view, toView: self.popupView!)
            viewController.didMove(toParent: self)
            return viewController
        }
        
        return nil
    }
    
    fileprivate func addChildViewController(with controller: UIViewController?)-> UIViewController? {
        if let controller = controller {
            self.addChild(controller)
            controller.view.frame = self.view.bounds
            self.addSubview(subView: controller.view, toView: self.popupView!)
            controller.didMove(toParent: self)
            return controller
        }
        return nil
    }
    
    //Remove popup
    fileprivate func removeAllChildViewController() {
        self.children.forEach({ (controller) in
            controller.view.removeFromSuperview()
            controller.willMove(toParent: nil)
            controller.removeFromParent()
        })
    }
    
    //Popup Present Animation
    fileprivate func setupPresentAnimation(type: PopupAnimation){
        switch type {
        case .normal:
            fromNone()
        case .top:
            fromTop()
        case .bottom:
            fromBottom()
        case .topBounce:
            fromTopBounce()
        case .bottomBounce:
            fromBottomBounce()
        }
    }
    
    //Popup Dismiss Animation
    fileprivate func setupDismissAnimation(type:PopupAnimation){
        switch type {
        case .normal:
            toNone()
        case .top:
            toTop()
        case .bottom:
            toBottom()
        case .topBounce:
            toTopBounce()
        case .bottomBounce:
            toBottomBounce()
        }
    }
    
    //Present from normal animation
    fileprivate func fromNone() {
        if let popupView = popupView{
            popupView.alpha = 0
            UIView.animate(withDuration: TimeDelay.normal.value, animations: {
                popupView.alpha = 1
            }, completion: nil)
        }
    }
    
    //Present from top animation
    fileprivate func fromTop() {
        if let popupView = popupView {
            let frame = popupView.frame
            popupView.frame.origin.y = mainView.frame.origin.y - popupView.frame.height
            UIView.animate(withDuration: TimeDelay.top.value, animations: {
                popupView.frame = frame
            }, completion: nil)
        }
    }
    
    //Present from bottom animation
    fileprivate func fromBottom() {
        if let popupView = popupView {
            let frame = popupView.frame
            popupView.frame.origin.y = mainView.frame.height + popupView.frame.height
            UIView.animate(withDuration: TimeDelay.bottom.value, animations: {
                popupView.frame = frame
            }, completion: nil)
        }
    }
    
    //Present from top with bounce animation
    fileprivate func fromTopBounce() {
        if let popupView = popupView {
            let frame = popupView.frame
            popupView.frame.origin.y = mainView.frame.origin.y - popupView.frame.height
            UIView.animate(withDuration: TimeDelay.topBounce.value, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                popupView.frame = frame
            }, completion: nil)
        }
    }
    
    //Present from bottom with animation
    fileprivate func fromBottomBounce() {
        if let popupView = popupView {
            let frame = popupView.frame
            popupView.frame.origin.y = mainView.frame.height + popupView.frame.height
            UIView.animate(withDuration: TimeDelay.bottomBounce.value, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                popupView.frame = frame
            }, completion: nil)
        }
    }
    
    //Dismiss from normal animation
    fileprivate func toNone() {
        if let popupView = popupView{
            UIView.animate(withDuration: TimeDelay.normal.value, animations: {
                popupView.alpha = 0
            }, completion: { (animated) in
                self.removeContentView()
            })
        }
    }
    
    //Dismiss from top animation
    fileprivate func toTop() {
        if let popupView = popupView {
            UIView.animate(withDuration: TimeDelay.top.value, animations: {
                popupView.frame.origin.y = self.mainView.frame.origin.y - popupView.frame.height
            }, completion: { (animated) in
                self.removeContentView()
            })
        }
    }
    
    //Dismiss from bottom animation
    fileprivate func toBottom() {
        if let popupView = popupView {
            UIView.animate(withDuration: TimeDelay.bottom.value, animations: {
                popupView.frame.origin.y = self.mainView.frame.height + popupView.frame.height
            }, completion: { (animated) in
                self.removeContentView()
            })
        }
    }
    
    fileprivate func toTopBounce() {
        if let popupView = popupView {
            UIView.animate(withDuration: TimeDelay.topBounce.value, animations: {
                popupView.frame.origin.y = self.mainView.frame.origin.y - popupView.frame.height
            }, completion: { (animated) in
                self.removeContentView()
            })
        }
    }
    
    fileprivate func toBottomBounce() {
        if let popupView = popupView {
            UIView.animate(withDuration: TimeDelay.bottomBounce.value, animations: {
                popupView.frame.origin.y = self.mainView.frame.height + popupView.frame.height
            }, completion: { (animated) in
                self.removeContentView()
            })
        }
    }
    
    //Remove Content view from superView
    fileprivate func removeContentView(){
        contentView?.removeFromSuperview()
        contentView = nil
        removeAllChildViewController()
    }
    
    //Dismiss Popup
    @objc fileprivate func dismissPopupView() {
        setupDismissAnimation(type: self.animationType!)
    }
    
    //Dissmiss pop
    public func dismissPopup(completion: ( @escaping(TimeInterval) -> Void)) {
        defer {
            let bonusTime: TimeInterval = 0.02
            if let animationType = self.animationType {
                var dismissTime: TimeInterval = 0.31
                switch animationType {
                case .normal:
                    dismissTime = TimeDelay.normal.value + bonusTime
                case .top:
                    dismissTime = TimeDelay.top.value + bonusTime
                case .bottom:
                    dismissTime = TimeDelay.bottom.value + bonusTime
                case .bottomBounce:
                    dismissTime = TimeDelay.bottomBounce.value + bonusTime
                case .topBounce:
                    dismissTime = TimeDelay.topBounce.value + bonusTime
                }
                completion(dismissTime)
            } else {
                completion(TimeDelay.bottom.value + bonusTime)
            }
        }
        setupDismissAnimation(type: self.animationType!)
    }
}
