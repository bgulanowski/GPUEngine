//
//  AppDelegate.m
//  GPU Demo Mac
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "AppDelegate.h"

@import MetalKit;
@import GPUEngine;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet MTKView *metalView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
