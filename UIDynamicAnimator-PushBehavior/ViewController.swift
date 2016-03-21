//
//  ViewController.swift
//  UIDynamicAnimator-PushBehavior
//
//  Created by Nam (Nick) N. HUYNH on 3/21/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var pushBehavior: UIPushBehavior?
    var squareView: UIView?
    var squareViewAnchorView: UIView?
    var anchorView: UIView?
    var attachmentBehavior: UIAttachmentBehavior?
    var animator: UIDynamicAnimator?
    
    func createSmallSquareView() {
        
        squareView = UIView(frame: CGRectMake(0, 0, 80, 80))
        if let theSquare = squareView {
            
            theSquare.backgroundColor = UIColor.greenColor()
            theSquare.center = view.center
            
            squareViewAnchorView = UIView(frame: CGRect(x: 60, y: 0, width: 20, height: 20))
            squareViewAnchorView?.backgroundColor = UIColor.brownColor()
            
            squareView?.addSubview(squareViewAnchorView!)
            view.addSubview(theSquare)
            
        }
        
    }
    
    func createAnchorView() {
        
        anchorView = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        anchorView?.backgroundColor = UIColor.redColor()
        view.addSubview(anchorView!)
        
    }
    
    func createAnimatorAndBehavior() {
        
        animator = UIDynamicAnimator(referenceView: view)
        if let theSquare = squareView {
            
            let collision = UICollisionBehavior(items: [theSquare])
            collision.translatesReferenceBoundsIntoBoundary = true
            
            attachmentBehavior = UIAttachmentBehavior(item: squareView!, offsetFromCenter: UIOffset(horizontal: 30, vertical: -40), attachedToAnchor: anchorView!.center)
            
//            pushBehavior = UIPushBehavior(items: [theSquare], mode: UIPushBehaviorMode.Continuous)
            animator!.addBehavior(collision)
//            animator!.addBehavior(pushBehavior)
            animator!.addBehavior(attachmentBehavior)
            
        }
        
    }
    
    func createGestureRecognizer() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        view.addGestureRecognizer(panGesture)
        
    }
    
    func handlePan(pan: UIPanGestureRecognizer) {
        
        let tapPoint = pan.locationInView(view)
        attachmentBehavior?.anchorPoint = tapPoint
        anchorView?.center = tapPoint
        
    }
    
//    func handleTap(tap: UITapGestureRecognizer) {
//        
//        let tapPoint = tap.locationInView(view)
//        let squareViewCenterPoint = squareView?.center
//        let deltaX = tapPoint.x - squareViewCenterPoint!.x
//        let deltaY = tapPoint.y - squareViewCenterPoint!.y
//        let angle = atan2(deltaY, deltaX)
//        
//        pushBehavior?.angle = angle
//        
//        let distanceBetweenPoints = sqrt(pow(tapPoint.x - squareViewCenterPoint!.x, 2.0) + pow(tapPoint.y - squareViewCenterPoint!.y, 2.0))
//        
//        pushBehavior?.magnitude = distanceBetweenPoints / 200.0
//        
//    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        createGestureRecognizer()
        createSmallSquareView()
        createAnchorView()
        createAnimatorAndBehavior()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

