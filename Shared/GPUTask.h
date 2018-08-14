//
//  GPUTask.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <simd/simd.h>

@import Metal;

@protocol GPURenderHost;

@protocol GPUTask <NSObject>

// Called by GPUEngine
- (void)encodeTaskWithCommandBuffer:(id<MTLCommandBuffer>)commandBuffer;

@optional
- (void)configureEncoderResources:(id<MTLCommandEncoder>)encoder;
- (void)didComplete;

@end

@protocol BufferProducer <GPUTask>
@property (nonatomic, readonly) id<MTLBuffer> outBuffer;
@end

@protocol BufferConsumer <GPUTask>
- (instancetype)initWithLibrary:(id<MTLLibrary>)library buffer:(id<MTLBuffer>)buffer size:(vector_uint2)size;
@property (nonatomic, readonly) id<MTLBuffer> inBuffer;
@end

@protocol BufferMap <BufferProducer, BufferConsumer>
@end


@protocol TextureProducer <GPUTask>
@property (nonatomic, readonly) id<MTLTexture> outTexture;
@end

@protocol TextureConsumer <GPUTask>
- (instancetype)initWithLibrary:(id<MTLLibrary>)library texture:(id<MTLTexture>)texture host:(id<GPURenderHost>)host;
@property (nonatomic, readonly) id<MTLTexture> inTexture;
@end

@protocol BufferTransform <BufferConsumer, TextureProducer>
@end
