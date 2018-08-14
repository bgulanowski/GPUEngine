//
//  GPUEDrawFlatMesh.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-27.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUERenderTask.h"

@class GPUEMesh;

NS_ASSUME_NONNULL_BEGIN

@interface GPUEDrawFlatMesh : GPUERenderTask

@property (nonatomic) GPUEMesh *mesh;

- (instancetype)initWithWithLibrary:(id<MTLLibrary>)library vertexFunction:(NSString *)vertexName fragmentFunction:(NSString *)fragmentName host:(id<GPUERenderHost>)host NS_UNAVAILABLE;
- (instancetype)initWithWithLibrary:(id<MTLLibrary>)library host:(id<GPUERenderHost>)host NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
