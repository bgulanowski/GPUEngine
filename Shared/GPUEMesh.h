//
//  GPUEMesh.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-28.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Metal;

NS_ASSUME_NONNULL_BEGIN

@interface GPUEMesh : NSObject

@property (nonatomic) id<MTLBuffer> vertexBuffer;
@property (nonatomic) id<MTLBuffer> indexBuffer;

@property (nonatomic) NSUInteger vertexCount;
@property (nonatomic) NSUInteger indexCount;

@end

NS_ASSUME_NONNULL_END
