//
//  GPURenderTask.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GPUTask.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GPURenderHost
@property (readonly) MTLPixelFormat pixelFormat;
@property (readonly) MTLViewport viewport;
@property (readonly) MTLRenderPassDescriptor *renderPassDescriptor;
@property (readonly) id<MTLDrawable> drawable;
@end

@interface GPURenderTask : NSObject<GPUTask>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithWithLibrary:(id<MTLLibrary>)library vertexFunction:(NSString *)vertexName fragmentFunction:(NSString *)fragmentName host:(id<GPURenderHost>)host NS_DESIGNATED_INITIALIZER;

// Subclass responsibilities

- (void)configureEncoderResources:(id<MTLRenderCommandEncoder>)encoder NS_REQUIRES_SUPER;
- (void)drawWithEncoder:(id<MTLRenderCommandEncoder>)encoder;

@end

NS_ASSUME_NONNULL_END
