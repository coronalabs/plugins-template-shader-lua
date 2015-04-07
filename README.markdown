# Project Templates for Shader Effect Plugins

## Overview

This is a template/stationary for those interested in packaging their [custom shader effects](http://docs.coronalabs.com/daily/guide/graphics/customEffects.html) into plugins. You can use these plugins in your own [Corona](https://coronalabs.com/products/corona-sdk/) projects or distribute them in the [Corona Store](https://store.coronalabs.com)

With this project, you can package a single effect or multiple effects together in a plugin. Your plugin can contain just one type of effect (e.g. filter) or a combination of types (e.g. generators and composites).


## New projects

### Creating your project

To create a new project, the simplest process is to run [create_project.sh](create_project.sh) which requires a BASH shell:

```
cd /path/to/this/repo/
./create_project.sh /path/to/new/project/folder PLUGIN_NAME
```

If you do not have access to BASH, see [Manual Project Creation](#manual-project-creation) below.

(TODO: Create a .bat script for Windows users.)


### Project Files

Your new project should contain the following files and folders:

* [build.sh](build.sh)
* [lua/](lua/)
	+ __Test Harness:__
		+ [build.settings](lua/build.settings)
		+ [config.lua](lua/config.lua)
		+ [Image1.jpg](lua/Image1.jpg)
		+ [Image2.jpg](lua/Image2.jpg)
		+ [main.lua](lua/main.lua)
	+ __Shader Effect:__
		+ [kernel/](lua/kernel/)
			- These are stub/sample effects. See [Shader Effect Files](#shader-effect-files) below.
* [metadata.json](metadata.json)
* [README.markdown](README.markdown)


## Shader Effect Development

### Workflow

For workflow convenience, the test harness and shader effect code are integrated to simplify shader effect development:

* The test harness is in the [lua/](lua/) folder, including the [lua/main.lua](lua/main.lua) file.
* The shader effects are in the subfolder of the test harness: [lua/kernel/](lua/kernel/).

That way, you can open the test harness in the Corona Simulator, modify your shader effects, and preview those changes immediately.

You can also open the test harness in [CoronaViewer](https://github.com/coronalabs/CoronaViewer) to preview those changes immediately on a device.


### Shader Effect Files

The new project provides sample implementations of all 3 kinds of effects: 

* Generator: [gradient.lua](lua/kernel/generator/PLUGIN_NAME/gradient.lua)
* Filter: [bulge.lua](lua/kernel/filter/PLUGIN_NAME/bulge.lua)
* Composite: [add.lua](lua/kernel/composite/PLUGIN_NAME/add.lua)

You can use these as starting points for your own custom shader effects. A couple of bookkeeping items to keep in mind:

1. Remove any effect category that you do not plan to support. 
	* For example, if you only have generator effects, remove the `filter/` and `composite/` folders from the project.
2. Remember to rename the effect. This involves 3 steps:
	1. Rename the lua file. 
		+ For example `add.lua` => `subtract.lua`
	2. Update the `kernel.name` property. 
		+ For example: `kernel.name = "add"` => `kernel.name = "subtract"`
	3. Update the test harness (`main.lua`) so that you can test your new effect.
3. You can have more than multiple effects per plugin. 


### Device Testing

Device testing is very critical for several reasons:

* There are subtle differences in the flavor of GLSL that runs on desktop vs mobile. Even though your shader code compiles on a desktop (Mac/Win), you should make sure it also compiles on the device.
* Mobile GPU's also have key performance differences that will not be apparent when running in the Corona Simulator. You should verify that the performance of your shader effect is acceptable on a wide range of devices. In general, you will want to run it on the oldest device you plan to support.

[CoronaViewer](https://github.com/coronalabs/CoronaViewer) is a convenient way to develop your shader on a device, offering a similar workflow to the Corona Simulator.


## Corona Store Submission

### Preparing for Submission

If you'd like to submit a plugin, there are a few more steps you need to take:

1. Update [metadata.json](metadata.json). 
	* This contains several strings in ALL CAPS that should be replaced with information specific to your plugin. 
	* While the helper script has already done a replacement of `PLUGIN_NAME` for you, there are still several strings that need to be updated.
	* Please see the section `Replacing strings in ALL CAPS` in the [Plugin Submission Guidelines](http://docs.coronalabs.com/daily/native/plugin/submission.html) for a complete list.
2. Device Testing
	* See [Device Testing](#device-testing) above.
	* You should make sure your shader executes on iOS and Android devices. 
	* Verify that your shader code compiles on device
	* Understand potential performance issues on lower-end devices.
	* NOTE: Windows Phone 8 only supports precompiled shaders, so custom shader effects are not supported by those devices.

### Packaging Your Plugin

* There is a convenience script that takes care of packaging your plugin for submission to the Corona Store.
* To run the script, open a Terminal to your project's root folder. There should be a script called `build.sh` that you can run:

```
./build.sh
```

This will create several files:

* a `build/` folder
* a `build-{PLUGIN_NAME}.zip` that contains all the files in `build/`. This is the file you should submit.


## Appendix

### Namespace Details

The template project in this repo is designed to namespace your custom shader effects.

The string token `PLUGIN_NAME` is used in the names of files/folders and in the contents of files. The [create_project.sh](create_project.sh) replaces occurrences of `PLUGIN_NAME` appropriately.

### Manual Project Creation

As explained in 'Namespace Details', the [create_project.sh](create_project.sh) does bulk string replacement for you. 

You can manually replace all occurrences of `PLUGIN_NAME` yourself. Be sure to do this inside the contents of files __and__ in the names of files/folders themselves.

