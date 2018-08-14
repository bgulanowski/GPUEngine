//
//  ComputePyramid.h
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-07-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUComputeTask.h"

#import <simd/simd.h>

@interface ComputePyramid : GPUComputeTask<BufferProducer>

- (instancetype)initWithLibrary:(id<MTLLibrary>)library kernelFunction:(NSString *)kernelName NS_UNAVAILABLE;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library size:(vector_uint2)size NS_DESIGNATED_INITIALIZER;

@end
