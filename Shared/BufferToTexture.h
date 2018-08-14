//
//  BufferToTexture.h
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-07-22.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUComputeTask.h"

#import <simd/simd.h>

@interface BufferToTexture : GPUComputeTask<BufferConsumer, TextureProducer>

- (instancetype)initWithLibrary:(id<MTLLibrary>)library kernelFunction:(NSString *)kernelName NS_UNAVAILABLE;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library buffer:(id<MTLBuffer>)buffer size:(vector_uint2)size NS_DESIGNATED_INITIALIZER;

@end
