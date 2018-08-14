//
//  TexturePresent.h
//  Noise Lab-Mac
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GPUBlitTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface TexturePresent : GPUBlitTask

- (instancetype)initWithRenderPassDescriptor:(MTLRenderPassDescriptor *)descriptor source:(id<MTLTexture>)source;

@end

NS_ASSUME_NONNULL_END
