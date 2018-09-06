//
//  GPUERenderer.h
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-06-28.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <TargetConditionals.h>

@import MetalKit;

#import "GPUERenderTask.h"

@protocol GPUEProcess;

@class GPUERenderer;

@protocol GPUEProcessProvider<NSObject>
@optional
@property (readonly) id<GPUEProcess> process;
- (id<GPUEProcess>)processForRenderer:(GPUERenderer *)render;
@end

NS_ASSUME_NONNULL_BEGIN

@interface GPUERenderer : NSObject<MTKViewDelegate, GPUERenderHost>

@property (nonatomic, readonly) MTKView *view;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithProvider:(nullable id<GPUEProcessProvider>)provider view:(MTKView *)view NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
