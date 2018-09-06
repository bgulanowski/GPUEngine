//
//  GPUEBufferToTexture.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-22.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEComputeTask.h"

#import <simd/simd.h>

@interface GPUEBufferToTexture : GPUEComputeTask<GPUEBufferTransform>

@property (nonatomic) float min;
@property (nonatomic) float max;
@property (nonatomic) BOOL map;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library kernelFunction:(NSString *)kernelName NS_UNAVAILABLE;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library buffer:(id<MTLBuffer>)buffer size:(vector_uint2)size NS_DESIGNATED_INITIALIZER;

@end
