//
//  GPUEDrawTexture.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUERenderTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUEDrawTexture : GPUERenderTask<GPUETextureConsumer>

- (instancetype)initWithLibrary:(id<MTLLibrary>)library texture:(id<MTLTexture>)texture host:(id<GPUERenderHost>)host;

@end

@interface MTLSamplerDescriptor (RepeatingSampler)
+ (instancetype)repeatingSampler;
@end

NS_ASSUME_NONNULL_END
