//
//  GPUETexturePresent.m
//  Noise Lab-Mac
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUETexturePresent.h"

@interface GPUETexturePresent ()
@property (nonatomic, readonly) id<MTLTexture> destination;
@end

@implementation GPUETexturePresent

- (id<MTLTexture>)texture {
    return (id<MTLTexture>)[self resource];
}

- (instancetype)initWithRenderPassDescriptor:(MTLRenderPassDescriptor *)descriptor source:(id<MTLTexture>)source {
    self = [super initWithResource:source];
    if (self) {
        _destination = descriptor.colorAttachments[0].texture;
    }
    return self;
}

- (void)performBlitWithEncoder:(id<MTLBlitCommandEncoder>)encoder {
    id<MTLTexture> texture = [self texture];
    [encoder copyFromTexture:texture
                 sourceSlice:0
                 sourceLevel:0
                sourceOrigin:MTLOriginMake(0, 0, 0)
                  sourceSize:MTLSizeMake(texture.width, texture.height, texture.depth)
                   toTexture:_destination
            destinationSlice:0
            destinationLevel:0
           destinationOrigin:MTLOriginMake(0, 0, 0)];
}

@end
