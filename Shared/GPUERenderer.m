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

@interface GPUERenderer ()
@property (readonly) id<GPUEProcess> process;
@end

@implementation GPUERenderer {
    id<GPUEProcessProvider> _provider;
    CGSize _viewportSize;
    BOOL _useProperty;
}

- (instancetype)initWithProvider:(nullable id<GPUEProcessProvider>)provider view:(MTKView *)view {
    self = [super init];
    if (self) {
        _provider = provider;
        _useProperty = [_provider respondsToSelector:@selector(process)];
        _view = view;
        _view.delegate = self;
        [self mtkView:_view drawableSizeWillChange:view.bounds.size];
    }
    return self;
}

#pragma mark - Accessors

- (id<GPUEProcess>)process {
    return _useProperty ? _provider.process : [_provider processForRenderer:self];
}

- (id<MTLDrawable>)drawable {
    if (_view.device == nil) {
        _view.device = self.process.device;
    }
    return _view.currentDrawable;
}

#pragma mark - MTKViewDelegate

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
#if TARGET_OS_IPHONE
    float scale = view.contentScaleFactor;
#else
    float scale = 1.0;
#endif
    _viewportSize = CGSizeMake(size.width * scale, size.height * scale);
}

- (void)drawInMTKView:(MTKView *)view {
#if 1
    [self.process runWithDrawable:self.drawable];
#else
    id<GPUEProcess> process = _provider.process;
    id<MTLDrawable> drawable = self.drawable;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        [process runWithDrawable:drawable];
    });
#endif
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
