-- 
-- Abstract: CustomEffect sample app
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2015 Corona Labs Inc. All Rights Reserved.
--
-- Supports Graphics 2.0
--
-- v1.0		2/4/2015
------------------------------------------------------------

-- Setup
local easing = require "easing"
display.setStatusBar( display.HiddenStatusBar ) 

------------------------------------------------------------

-- Debugging: 
-- Log compiler errors found in shader code to console
display.setDefault( 'isShaderCompilerVerbose', true )

------------------------------------------------------------

local function testGenerator( x, y, w, h )
	local obj = display.newRect( x, y, w, h )

	-- Load custom effect
	local name = "generator.PLUGIN_NAME.gradient"
	local kernel = require( "kernel." .. name )
	graphics.defineEffect( kernel )

	-- Apply effect
	obj.fill.effect = name
end

------------------------------------------------------------

local function testFilter( x, y, w, h )
	local obj = display.newImageRect( "Image1.jpg", w, h )
	obj.x = x
	obj.y = y

	-- Load custom effect
	local name = "filter.PLUGIN_NAME.bulge"
	local kernel = require( "kernel." .. name )
	graphics.defineEffect( kernel )

	-- Apply effect
	obj.fill.effect = name

	-- Effect parameter
	obj.fill.effect.intensity = 0
	transition.to(
		obj.fill.effect,
		{ intensity = 1, time = 5000, transition = easing.outExpo } )
end

------------------------------------------------------------

local function testComposite( x, y, w, h )
	local obj = display.newRect( x, y, w, h )
	obj.fill = {
		type = "composite",
		paint1 = { type = "image", filename = "Image1.jpg" },
		paint2 = { type = "image", filename = "Image2.jpg" },
	}

	-- Load custom effect
	local name = "composite.PLUGIN_NAME.add"
	local kernel = require( "kernel." .. name )
	graphics.defineEffect( kernel )

	-- Apply effect
	obj.fill.effect = name

	-- Effect parameter
	obj.fill.effect.alpha = 0
	transition.to(
		obj.fill.effect,
		{ alpha = 1, time = 5000, transition = easing.outExpo } )
end

------------------------------------------------------------

local x, y = display.contentCenterX, display.contentCenterY
local w, h = 200, 132

testGenerator( x, y - h, w, h )

testFilter( x, y, w, h )

testComposite( x, y + h, w, h )

------------------------------------------------------------
