//
//  GPUEComputeTask.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <simd/simd.h>

#import "GPUETask.h"

#if TARGET_OS_IPHONE
#define STORAGE_MODE MTLResourceStorageModeShared
#else
#define STORAGE_MODE MTLResourceStorageModeManaged
#endif

NS_ASSUME_NONNULL_BEGIN

@interface GPUEComputeTask : NSObject<GPUETask> {
@protected
    BOOL _shouldRun;
}

@property (nonatomic, readonly) MTLSize threadgroupSize;
@property (nonatomic, readonly) BOOL hasRun;
@property (nonatomic, readonly) BOOL shouldRun;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithLibrary:(id<MTLLibrary>)library kernelFunction:(NSString *)kernelName NS_DESIGNATED_INITIALIZER;

- (void)configureEncoder:(id<MTLComputeCommandEncoder>)encoder;

// Subclass responsibilities
@property (nonatomic, readonly) MTLSize threadCount;

- (void)configureEncoderResources:(id<MTLComputeCommandEncoder>)encoder;

@end

NS_ASSUME_NONNULL_END
