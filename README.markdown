# Project Template for Shader Effect Plugins


## Overview

This is a template/stationary for those interested in packaging their [custom shader effects](http://docs.coronalabs.com/daily/guide/graphics/customEffects.html) into plugins. You can use these plugins in your own [Corona](https://coronalabs.com/products/corona-sdk/) projects or distribute them in the [Corona Store](https://store.coronalabs.com)

With this project, you can package a single effect or multiple effects together in a plugin. Your plugin can contain just one type of effect (e.g. filter) or a combination of types (e.g. generators and composites).


## New projects

### Creating your project

To create a new project, we have provided helper scripts that can do the necessary file renaming and string replacements for both Mac OS X and Windows.

#### Mac

Run the script [create_project.sh](create_project.sh) in Terminal:

```
cd /path/to/this/repo/
./create_project.sh /path/to/new/project/folder PLUGIN_NAME
```

#### Windows

Run the script [create_project.bat](create_project.bat) in the command prompt:

```
cd \path\to\this\repo\
create_project.bat \path\to\new\project\folder PLUGIN_NAME
```


### Project Files

Your new project should contain the following files and folders:

* [bin/](bin/): Core binaries required by the build process.
+ [build.bat](build.bat): Compiles and packages the plugin for distribution using Windows.
+ [build.sh](build.sh): Compiles and packages the plugin for distribution using a Mac.
* [metadata.json](metadata.json): Contains publisher information, including contact and website data.
* [lua/](lua/)
	+ __Test Harness:__
		+ [build.settings](lua/build.settings)
		+ [config.lua](lua/config.lua)
		+ [main.lua](lua/main.lua)
	+ __Shader Effect:__
		+ [kernel/](lua/kernel/)
			- These are stub/sample effects. See [Shader Effect Files](#shader-effect-files) below.

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

If you'd like to [submit a plugin](https://store.coronalabs.com/corona-store-application), there are a few more steps you need to take:

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
3. Documentation
	* Fork or clone [Doc Template for Shader Docs](https://github.com/coronalabs/plugins-template-shader-docs)
	* Follow the [Instructions](https://github.com/coronalabs/plugins-template-shader-docs/blob/master/Instructions.markdown)
4. Sample Code
	* Post sample code online, e.g. github.

### Packaging Your Plugin

The packaging of your submission should follow a specific structure.

There is a convenience script that takes care of creating this structure (`build.sh` or `build.bat`). You must provide it with the daily build number corresponding to the minimum supported version of Corona (e.g. the first version of Corona you'd like the plugin to work with).

#### Example

For example, let's pretend we are submitting this repo's project. We'd like it to start working with daily build 2015.2642, so we would do the following:

* On Mac, from Terminal: `./build.sh`
* On Windows, from the command prompt: `build.bat`

In both cases, we are assuming the current working directory is the base directory of the project.

By default, the results will be placed in a `build` directory:

* `plugins/`
	+ `2015.2642/`
		- `lua/`
			- `kernel/`
				- `composite/`
					- `PLUGIN_NAME/`
						- `add.lua`
				- `filter/`
					- `PLUGIN_NAME/`
						- `bulge.lua`
				- `generator/`
					- `PLUGIN_NAME/`
						- `gradient.lua`
* `metadata.json`
