//
//  GPUETask.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <simd/simd.h>

@import Metal;

@protocol GPUERenderHost;

@protocol GPUETask <NSObject>

// Called by GPUEEngine
- (void)encodeTaskWithCommandBuffer:(id<MTLCommandBuffer>)commandBuffer;

@optional
- (void)configureEncoderResources:(id<MTLCommandEncoder>)encoder;
- (void)didComplete;

@end

@protocol GPUEBufferProducer <GPUETask>
@property (nonatomic, readonly) id<MTLBuffer> outBuffer;
@end

@protocol GPUEBufferConsumer <GPUETask>
- (instancetype)initWithLibrary:(id<MTLLibrary>)library buffer:(id<MTLBuffer>)buffer size:(vector_uint2)size;
@property (nonatomic, readonly) id<MTLBuffer> inBuffer;
@end

@protocol GPUEBufferMap <GPUEBufferProducer, GPUEBufferConsumer>
@end


@protocol GPUETextureProducer <GPUETask>
@property (nonatomic, readonly) id<MTLTexture> outTexture;
@end

@protocol GPUETextureConsumer <GPUETask>
- (instancetype)initWithLibrary:(id<MTLLibrary>)library texture:(id<MTLTexture>)texture host:(id<GPUERenderHost>)host;
@property (nonatomic, readonly) id<MTLTexture> inTexture;
@end

@protocol GPUEBufferTransform <GPUEBufferConsumer, GPUETextureProducer>
@end
