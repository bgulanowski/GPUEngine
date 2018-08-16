//
//  GPUEEngine.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GPUETask.h"

@interface GPUEEngine : NSObject

@property (nonatomic, readonly) id<MTLDevice> device;
@property (nonatomic, readonly) id<MTLLibrary> library; // Framework bundle
@property (nonatomic, readonly) id<MTLLibrary> appLibrary; // Main bundle

- (instancetype)initWithDevice:(id<MTLDevice>)device library:(id<MTLLibrary>)library NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithDevice:(id<MTLDevice>)device; // default library
- (instancetype)init; // default device and default library

- (id<MTLLibrary>)libraryForBundle:(NSBundle *)bundle;
- (id<MTLLibrary>)libraryForClass:(Class)klass;

- (void)runTasks:(NSArray<id<GPUETask>> *)tasks withDrawable:(id<MTLDrawable>)drawable;
- (void)runTasks:(NSArray<id<GPUETask>> *)tasks;

@end
