//
//  AppDelegate.m
//  GPU Demo Mac
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "AppDelegate.h"
#import "Process.h"

@import MetalKit;
@import GPUEngine;

@interface AppDelegate ()<GPUEProcessProvider>

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet MTKView *metalView;

@property GPUEEngine *engine;
@property GPUERenderer *renderer;

@property Process *process;

@end

@implementation AppDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _engine = [[GPUEEngine alloc] init];
    }
    return self;
}

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _renderer = [[GPUERenderer alloc] initWithProvider:self view:self.metalView];
    self.process = [[Process alloc] initWithEngine:_engine host:_renderer];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
