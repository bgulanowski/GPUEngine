//
//  GPUEngine.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GPUEngine.
FOUNDATION_EXPORT double GPUEngineVersionNumber;

//! Project version string for GPUEngine.
FOUNDATION_EXPORT const unsigned char GPUEngineVersionString[];

// Core
#import <GPUEngine/GPUEEngine.h>
#import <GPUEngine/GPUETask.h>
#import <GPUEngine/GPUEProcess.h>

// Task Types
#import <GPUEngine/GPUEBlitTask.h>
#import <GPUEngine/GPUEComputeTask.h>
#import <GPUEngine/GPUERenderTask.h>

// Generic Tasks
#import <GPUEngine/GPUEBufferToTexture.h>
#import <GPUEngine/GPUEDrawFlatMesh.h>
#import <GPUEngine/GPUEDrawTexture.h>
#import <GPUEngine/GPUETexturePresent.h>

// Sample Tasks
#import <GPUEngine/GPUEComputePyramid.h>

// Data Types
#import <GPUEngine/GPUEMesh.h>
#import <GPUEngine/GPUEShaderTypes.h>

// Utilities
#import <GPUEngine/GPUECGImageUtilities.h>
