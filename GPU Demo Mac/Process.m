//
//  Process.m
//  GPU Demo Mac
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "Process.h"

@interface Process ()
@property NSArray<id<GPUETask>> *tasks;
@end


@implementation Process

@synthesize engine = _engine;
@synthesize onComplete=_onComplete;

- (id<MTLDevice>)device {
    return _engine.device;
}

- (BOOL)needsRefresh {
    return NO;
}

- (instancetype)initWithEngine:(GPUEEngine *)engine host:(id<GPUERenderHost>)renderHost {
    self = [super init];
    if (self) {
        _engine = engine;
        id<GPUEBufferProducer> generate = [[GPUEComputePyramid alloc] initWithLibrary:engine.library size:1024u];
        id<GPUEBufferTransform> transform = [[GPUEBufferToTexture alloc] initWithLibrary:engine.library buffer:generate.outBuffer size:1024u];
        id<GPUETextureConsumer> draw = nil;
        
        if (renderHost) {
            draw = [[GPUEDrawTexture alloc] initWithLibrary:engine.library texture:transform.outTexture host:renderHost];
            self.tasks = @[generate, transform, draw];
        }
        else {
            self.tasks = @[ generate, transform];
        }
    }
    return self;
}

- (void)run {}

- (void)runWithDrawable:(id<MTLDrawable>)drawable {
    [_engine runTasks:self.tasks withDrawable:drawable];
}

- (instancetype)initWithEngine:(GPUEEngine *)engine {
    return [self initWithEngine:engine host:nil];
}

@end

