//
//  GPUERenderer.m
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-06-28.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUERenderer.h"

#import "GPUEngine.h"
#import "GPUEProcess.h"

@implementation GPUERenderer {
    id<GPUEProcessProvider> _provider;
    CGSize _viewportSize;
}

- (instancetype)initWithProvider:(nullable id<GPUEProcessProvider>)provider view:(MTKView *)view {
    self = [super init];
    if (self) {
        _provider = provider;
        _view = view;
        _view.delegate = self;
        _viewportSize = view.bounds.size;
    }
    return self;
}

#pragma mark - Accessors

- (id<MTLDrawable>)drawable {
    if (_view.device == nil) {
        _view.device = _provider.process.device;
    }
    return _view.currentDrawable;
}

#pragma mark - MTKViewDelegate

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    _viewportSize = size;
}

- (void)drawInMTKView:(MTKView *)view {
    [_provider.process runWithDrawable:self.drawable];
}

- (MTLViewport)viewport {
    MTLViewport viewport;
    double aspect = _viewportSize.height / _viewportSize.width;
    if (aspect < 1.0) {
        viewport.originX = -(_viewportSize.height - _viewportSize.width) / 2.0;
        viewport.originY = 0;
        viewport.width = _viewportSize.height;
        viewport.height = _viewportSize.height;
    }
    else {
        viewport.originX = 0;
        viewport.originY = -(_viewportSize.width - _viewportSize.height) / 2.0;
        viewport.width = _viewportSize.width;
        viewport.height = _viewportSize.width;
    }
    return viewport;
}

#pragma mark - GPURenderHost

- (MTLPixelFormat)pixelFormat {
    return _view.colorPixelFormat;
}

- (MTLRenderPassDescriptor *)renderPassDescriptor {
    return _view.currentRenderPassDescriptor;
}

@end
