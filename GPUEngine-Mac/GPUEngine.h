//
//  GPUEngine.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for GPUEngine.
FOUNDATION_EXPORT double GPUEngineVersionNumber;

//! Project version string for GPUEngine.
FOUNDATION_EXPORT const unsigned char GPUEngineVersionString[];

// Core
#import "GPUEEngine.h"
#import "GPUETask.h"
#import "GPUEProcess.h"

// Task Types
#import "GPUEBlitTask.h"
#import "GPUEComputeTask.h"
#import "GPUERenderTask.h"

// Generic Tasks
#import "GPUEBufferToTexture.h"
#import "GPUEDrawFlatMesh.h"
#import "GPUEDrawTexture.h"
#import "GPUEQuantize.h"
#import "GPUEResourceSync.h"
#import "GPUETexturePresent.h"

// Sample Tasks
#import "GPUEComputePyramid.h"

// Data Types
#import "GPUEMesh.h"
#import "GPUEShaderTypes.h"

// Utilities
#import "GPUECGImageUtilities.h"
#import "GPUERenderer.h"

#import "NSImage+Bitmap.h"
