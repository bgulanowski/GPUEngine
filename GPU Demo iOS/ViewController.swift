//
//  ViewController.swift
//  GPU Demo iOS
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

import UIKit
import MetalKit
import GPUEngine

class ViewController: UIViewController, GPUEProcessProvider {
    
    @IBOutlet weak var metalView: MTKView!

    var engine = GPUEEngine()!
    var renderer: GPUERenderer!
    
    var _process : Process!
    
    var process : GPUEProcess {
        get {
            return _process as GPUEProcess
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        renderer = GPUERenderer(provider: self, view: self.metalView)
        _process = Process(engine: engine, renderHost: renderer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

