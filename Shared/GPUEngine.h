//
//  GPUEngine.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GPUTask.h"

@interface GPUEngine : NSObject

@property (nonatomic, readonly) id<MTLDevice> device;
@property (nonatomic, readonly) id<MTLLibrary> library;

- (instancetype)initWithDevice:(id<MTLDevice>)device library:(id<MTLLibrary>)library NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithDevice:(id<MTLDevice>)device; // default library
- (instancetype)init; // default device and default library

- (void)runTasks:(NSArray<id<GPUTask>> *)tasks withDrawable:(id<MTLDrawable>)drawable;
- (void)runTasks:(NSArray<id<GPUTask>> *)tasks;

@end
