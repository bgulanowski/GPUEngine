//
//  Process.swift
//  GPU Demo iOS
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

import UIKit
import GPUEngine

class Process: NSObject, GPUEProcess {
    
    let size : uint = 1024
    
    var device : MTLDevice {
        get {
            return engine.device
        }
    }
    
    lazy var tasks: [GPUETask] = {
        let size = vector_uint2(self.size, self.size)
        let gen = GPUEComputePyramid(library: engine.library, size: size)!
        let transform = GPUEBufferToTexture(library: engine.library, buffer: gen.outBuffer, size: size)!
        let draw = GPUEDrawTexture(library: engine.library, texture: transform.outTexture, host: renderHost)
        return [ gen, transform, draw ]
    }()
    
    var needsRefresh: Bool {
        get {
            return true
        }
    }
    
    var refresh: (() -> Void)!
    
    var onComplete: (() -> Void)!
    
    func run() {
        engine.run(tasks)
    }
    
    func run(with drawable: MTLDrawable!) {
        engine.run(tasks, with: drawable)
    }
    
    var engine: GPUEEngine!
    var renderHost : GPUERenderHost!

    required init!(engine: GPUEEngine!) {
        self.engine = engine
    }
    
    init(engine: GPUEEngine, renderHost: GPUERenderHost) {
        self.engine = engine
        self.renderHost = renderHost
    }
}
