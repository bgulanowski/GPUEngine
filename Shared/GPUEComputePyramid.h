//
//  ComputePyramid.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEComputeTask.h"

#import <simd/simd.h>

@interface GPUEComputePyramid : GPUEComputeTask<GPUEBufferProducer>

- (instancetype)initWithLibrary:(id<MTLLibrary>)library kernelFunction:(NSString *)kernelName NS_UNAVAILABLE;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library size:(vector_uint2)size NS_DESIGNATED_INITIALIZER;

@end
