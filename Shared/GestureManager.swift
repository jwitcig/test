//
//  GestureManager.swift
//  MrPutt
//
//  Created by Developer on 1/20/17.
//  Copyright © 2017 CodeWithKenny. All rights reserved.
//

import UIKit

class GestureManager {
    weak var delegate: UIGestureRecognizerDelegate?
    
    lazy var pan: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer(target: self.delegate, action: #selector(PuttScene.handlePan(recognizer:)))
        pan.minimumNumberOfTouches = 1
        pan.delegate = self.delegate
        return pan
    }()
    
    lazy var zoom: UIPinchGestureRecognizer = {
        let zoom = UIPinchGestureRecognizer(target: self.delegate, action: #selector(PuttScene.handleZoom(recognizer:)))
        zoom.delegate = self.delegate
        return zoom
    }()
    
    var recognizers: [UIGestureRecognizer] {
        return [pan, zoom]
    }
    
    init(delegate: UIGestureRecognizerDelegate) {
        self.delegate = delegate
    }
    
    func addRecognizers(to view: UIView) {
        recognizers.forEach(view.addGestureRecognizer)
    }
    
    func remove(recognizer: UIGestureRecognizer, from view: UIView) {
        view.removeGestureRecognizer(recognizer)
    }
    
    func remove(recognizers: [UIGestureRecognizer], from view: UIView) {
        for recognizer in recognizers {
            remove(recognizer: recognizer, from: view)
        }
    }
}
