//
//  DrawTexture.h
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPURenderTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawTexture : GPURenderTask<TextureConsumer>

- (instancetype)initWithLibrary:(id<MTLLibrary>)library texture:(id<MTLTexture>)texture host:(id<GPURenderHost>)host;

@end

@interface MTLSamplerDescriptor (RepeatingSampler)
+ (instancetype)repeatingSampler;
@end

NS_ASSUME_NONNULL_END
