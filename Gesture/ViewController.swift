//
//  ViewController.swift
//  Gesture
//
//  Created by SD.Man on 2021/1/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var pinchLabel: UILabel!
    @IBOutlet weak var rotateLabel: UILabel!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var panLabel: UILabel!
    @IBOutlet weak var screenEdgePanLabel: UILabel!
    @IBOutlet weak var longPressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(tap:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(pinch:)))
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(rotation:)))
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipe:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
        let screenEdgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePan(screenEdgePan:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPress:)))
        
        tapLabel.addGestureRecognizer(tapGesture)
        pinchLabel.addGestureRecognizer(pinchGesture)
        rotateLabel.addGestureRecognizer(rotationGesture)
        
        // swipeGesture.direction = .right
        // swipeGesture.numberOfTouchesRequired = 1
        swipeLabel.addGestureRecognizer(swipeGesture)
        
        // panGesture.maximumNumberOfTouches最大的手指数
        panLabel.addGestureRecognizer(panGesture)
        
        screenEdgePanGesture.edges = .left
        // 给屏幕边缘添加手势
        view.addGestureRecognizer(screenEdgePanGesture)
        
        // longPressGesture.numberOfTapsRequired = 0 长按之前默认不需要点击
        longPressLabel.addGestureRecognizer(longPressGesture)
    }

    @objc func handleTap(tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            tapLabel.text = "Tap轻触"
            tapLabel.textColor = .red
        }
    }
    
    @objc func handlePinch(pinch: UIPinchGestureRecognizer) {
        if pinch.state == .began || pinch.state == .changed {
            pinchLabel.transform = pinchLabel.transform.scaledBy(x: pinch.scale, y: pinch.scale)
            pinch.scale = 1 // 阶乘
        }
    }
    
    @objc func handleRotation(rotation: UIRotationGestureRecognizer) {
        if rotation.state == .began || rotation.state == .changed {
            rotateLabel.transform = rotateLabel.transform.rotated(by: rotation.rotation)
            rotation.rotation = 0 // 叠加
            // rotation.velocity 旋转速度
        }
    }
    
    // 离散手势，不适合交互
    @objc func handleSwipe(swipe: UISwipeGestureRecognizer) {
        if swipe.state == .ended {
            swipeLabel.text = "Swipe轻扫"
            swipeLabel.textColor = .red
        }
    }
    
    // 持续手势
    var startPoint = CGPoint.zero // 用于获取panLabel起始位置
    @objc func handlePan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: panLabel.superview)
        if pan.state == .began {
            startPoint = panLabel.center
        }
        if pan.state != .cancelled {
            panLabel.center = CGPoint(x: startPoint.x + translation.x, y: startPoint.y + translation.y)
        } else {
            panLabel.center = startPoint
        }
    }
    
    @objc func handleScreenEdgePan(screenEdgePan: UIScreenEdgePanGestureRecognizer) {
        let x = screenEdgePan.translation(in: view).x
        
        if screenEdgePan.state == .began || screenEdgePan.state == .changed {
            screenEdgePanLabel.transform = CGAffineTransform(translationX: x, y: 0)
        } else {
            UIView.animate(withDuration: 0.3) {
                self.screenEdgePanLabel.transform = .identity // 归零
            }
        }
    }
    
    // 持续手势
    @objc func handleLongPress(longPress: UILongPressGestureRecognizer) {
        if longPress.state == .ended {
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            }
        }
    }

}

