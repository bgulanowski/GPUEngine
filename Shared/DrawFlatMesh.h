//
//  DrawFlatMesh.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-27.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPURenderTask.h"

@class Mesh;

NS_ASSUME_NONNULL_BEGIN

@interface DrawFlatMesh : GPURenderTask

@property (nonatomic) Mesh *mesh;

- (instancetype)initWithWithLibrary:(id<MTLLibrary>)library vertexFunction:(NSString *)vertexName fragmentFunction:(NSString *)fragmentName host:(id<GPURenderHost>)host NS_UNAVAILABLE;
- (instancetype)initWithWithLibrary:(id<MTLLibrary>)library host:(id<GPURenderHost>)host NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
