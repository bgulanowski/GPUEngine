# GPUEngine

### A fancy name for a simple library.

GPUEngine is a collection of classes designed to make it easier to work with Metal on macOS and iOS. It hides away the usual boilerplate of setting up the Metal library objects that you need, and the work of connecting them together, and with your own code.

The essential idea is that there is an Engine that runs Tasks: classes that conform to `GPUETask`. There are three kinds of specialized task (two on iOS): Blit (macOS only), Compute, and Render. These are implemented abstractly by the classes `GPUEBlitTask`, `GPUEComputeTask`, and `GPUERenderTask`, respectively.

The simplest way to use GPUEngine is to create a custom Compute task. That is, a class that inherits from `GPUEComputeTask` . Instantiate an instace of `GPUEEngine`, an instance of your task class, and then submit it to the engine by wrapping it in an array, and sending a `-runTasks:` message with the array as the sole argument.

If you want to draw to the screen, you would create a class that conforms to `GPUERenderTask`, and use `runTasks:withDrawable:`.

Tasks are meant to be chained together. There are specialized protocols which define whether a task consumes or produces output resources. Resources, as defined by Metal, are of two kinds: `MTLBuffer` and `MTLTexture`. A `GPUEBufferProducer` declares an `outBuffer` property. This can be used an input to a `GPUEBufferConsumer`. Similarly for `GPUETextureProducer` and `GPUETextureConsumer`.

`GPUEBufferMap` takes a `MTLBuffer` and produces another `MTLBuffer`. `GPUEBufferTransformer` takes a `MTLBuffer` and produces a `MTLTexture`. These are all just protocols, however. In effect, they are just suggestions for how to organize a sequence of simple GPU functions.

Each compute and render task requires associated Metal functions: a compute kernel, or a pair of vertex and fragment functions, respectively. The job of the task is quite simple: it declares the function names, and it submits encoded commands on demand, in `-encodeTaskWithCommandBuffer:`. The abstract task classes already implement this method. Subclassers are encouraged to instead implement `-configureEncoderReources:`, and append their resources to the provided encoder.

The Task pattern is extended by the Process pattern, defined by the `GPUEProcess` protocol. A process takes over more of the work of managing a group of tasks, submitting them to the engine, and triggering refresh and completion blocks when necessary. (There is still no reference implementation of `GPUEProcess`. Should be coming soon.) A process should be able to descriminate between which tasks need to run, based on what dependencies have been modified.

Finally, the last piece of the puzzle is the `GPUERenderer`. As its name suggests, it expects to work with render tasks. There is no need for a renderer when using only compute and blit tasks. Like the other classes in the library, it's quite simple. It's purpose is to abstract away tedious glue code that otherwise might get mixed up in controller classes, where it doesn't really belong. It provides a connection between the `GPUEEngine`—via a `GPUEProcess`—and a `MTKView`. It acts as the view's delegate, running the process each time a new frame is requested by the view.

The library also includes a few basic tasks.

- `GPUEComputePyramid` demonstrates a simple compute task that fills a buffer with rectangles that are reminiscent of pyramid shapes on a plane.
- `GPUEBufferToTexture` demonstrates a buffer transformer; it converts a buffer of floating point values into a texture.
- `GPUEDrawTexture` demonstrates a simple texture consumer; it draws a full-screen quad with the given texture applied.
- `GPUEDrawFlatMesh` demonstrates a buffer consumer; it draws a `GPUEMesh`. (See below)
- `GPUETexturePresent` demonstrates a blit task; it draws a texture directly into a render buffer without the need for geometry. (TODO: verify it works!)

A `GPUEMesh` is a trivial container for vertices and indices held in `MTLBuffer` objects.

`GPUECGImageUtilities` contains a set of functions for converting raw data blobs into bitmaps, instances of `CGContextRef` objects. There are also convenience categories on `NSImage` and `UIImage` for converting bitmaps into instances of those classes. (Using these interfaces might result in superfluous data copying, but for one-shot operations, this should not be an issue.)  

There are sample applications for both macOS (in Objective-C) and iOS (in Swift).
