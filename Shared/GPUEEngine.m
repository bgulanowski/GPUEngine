//
//  GPUEEngine.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEEngine.h"

@interface GPUEEngine ()

@property (nonatomic) id<MTLDevice> device;
@property (nonatomic) id<MTLCommandQueue> commandQueue;
@property (nonatomic) NSMutableDictionary<NSString*, id<MTLLibrary>> *libraries;

@end

@implementation GPUEEngine

#pragma mark - NSOBject

- (instancetype)init {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    NSError *error = nil;
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    id<MTLLibrary> library = [device newDefaultLibraryWithBundle:bundle error:&error];
    if (nil == library || error) {
        NSLog(@"Unable to load library: %@", error);
    }
    else {
        library.label = bundle.bundleIdentifier;
    }
    return [self initWithDevice:device library:library];
}

#pragma mark - Designated Initializer

- (instancetype)initWithDevice:(id<MTLDevice>)device library:(id<MTLLibrary>)library {
    self = [super init];
    if (self) {
        _device = device;
        _library = library;
        _commandQueue = [device newCommandQueue];
        _libraries = [NSMutableDictionary new];
        _libraries[_library.label] = library;
        _appLibrary = [self libraryForBundle:[NSBundle mainBundle]];
    }
    return self;
}

#pragma mark - Convenience Initializer

- (instancetype)initWithDevice:(id<MTLDevice>)device {
    return [self initWithDevice:device library:[device newDefaultLibrary]];
}

#pragma mark - GPUEngine

- (id<MTLLibrary>)libraryForBundle:(NSBundle *)bundle error:(NSError **)error {
    id<MTLLibrary> library = _libraries[bundle.bundleIdentifier];
    if (nil == library) {
        library = [_device newDefaultLibraryWithBundle:bundle error:error];
        if (library) {
            library.label = bundle.bundleIdentifier;
            _libraries[library.label] = library;
        }
    }
    return library;
}

- (id<MTLLibrary>)libraryForBundle:(NSBundle *)bundle {
    return [self libraryForBundle:bundle error:NULL];
}

- (id<MTLLibrary>)libraryForClass:(Class)klass {
    return [self libraryForBundle:[NSBundle bundleForClass:klass]];
}

- (void)runTasks:(NSArray<id<GPUETask>> *)tasks withDrawable:(id<MTLDrawable>)drawable {
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    for (id<GPUETask> task in tasks) {
        [task encodeTaskWithCommandBuffer:commandBuffer];
    }
    
    if (drawable) {
        [commandBuffer presentDrawable:drawable];
    }
    [commandBuffer commit];
    [commandBuffer waitUntilCompleted];
    
    for (id<GPUETask> task in tasks) {
        if ([task respondsToSelector:@selector(didComplete)]) {
            [task didComplete];
        }
    }
}

- (void)runTasks:(NSArray<id<GPUETask>> *)tasks {
    [self runTasks:tasks withDrawable:nil];
}

@end
