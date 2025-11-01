-- Compiled with roblox-ts v3.0.0
local TS = _G[script]
--[[
	*
	 * @fileoverview A simple module loader for RBXTS.
	 * @author Emilia (NotDumbDev)
	 * @license MIT
	 * @copyright 2025 Emilia (NotDumbDev)
	 * @note Please credit the original creator (Emilia / NotDumbDev) when redistributing or modifying the project!
	 
]]
-- types \\
-- cache \\
local moduleCache = {}
-- private functions \\
local function hasInitFunc(value)
	local _arg0 = value.OnInit
	return type(_arg0) == "function"
end
local function hasStartFunc(value)
	local _arg0 = value.OnStart
	return type(_arg0) == "function"
end
local function InitializeModule(element)
	local initalizeTime = os.clock()
	if hasInitFunc(element.module) then
		element.module.OnInit()
		local elapsedTime = os.clock() - initalizeTime
		local formattedTime = if elapsedTime > 1 then string.format("%.3f", elapsedTime) else string.format("%.2f", elapsedTime)
		warn(`[{formattedTime}s]: Intialized '{element.name}'!`)
	end
end
local function StartModule(element)
	local startTime = os.clock()
	if hasStartFunc(element.module) then
		element.module.OnStart()
		local elapsedTime = os.clock() - startTime
		local formattedTime = if elapsedTime > 1 then string.format("%.3f", elapsedTime) else string.format("%.2f", elapsedTime)
		warn(`[{formattedTime}s]: Started '{element.name}'!`)
	end
end
-- public api \\
local InitializeModules = TS.async(function(modules)
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(module)
		if not module:IsA("ModuleScript") then
			--warn(`Element given expected to be a ModuleScript, got ${typeOf(module)}`);
			return nil
		end
		local _result = module.Parent
		if _result ~= nil then
			_result = string.lower(_result.Name)
		end
		if _result == "components" then
			return nil
		end
		local _result_1 = module.Parent
		if _result_1 ~= nil then
			_result_1 = string.lower(_result_1.Name)
		end
		if _result_1 == "stories" then
			return nil
		end
		local mod = require(module)
		local _moduleCache = moduleCache
		local _arg0 = {
			name = tostring(module.Name),
			module = mod,
			parent = module.Parent,
		}
		table.insert(_moduleCache, _arg0)
	end
	for _k, _v in modules do
		_callback(_v, _k - 1, modules)
	end
	-- ▲ ReadonlyArray.forEach ▲
end)
--[[
	*
	 * Starts all modules.
	 * @param startModules ^^ A table of module scripts
	 * @yields Waits for the modules to cache before starting.
	 
]]
local StartAll = TS.async(function(startModules)
	local _startModules = startModules
	local _arg1 = `Returned 0 module scripts!`
	assert(_startModules, _arg1)
	TS.await(InitializeModules(startModules))
	-- ▼ ReadonlyArray.forEach ▼
	local _callback = function(element)
		InitializeModule(element)
	end
	for _k, _v in moduleCache do
		_callback(_v, _k - 1, moduleCache)
	end
	-- ▲ ReadonlyArray.forEach ▲
	-- ▼ ReadonlyArray.forEach ▼
	local _callback_1 = function(element)
		StartModule(element)
	end
	for _k, _v in moduleCache do
		_callback_1(_v, _k - 1, moduleCache)
	end
	-- ▲ ReadonlyArray.forEach ▲
end)
return {
	StartAll = StartAll,
}
