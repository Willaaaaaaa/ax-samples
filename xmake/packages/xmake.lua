local chip_val = get_config("chip")
if get_config("chip") == "ax650" then
    includes("bsp_sdk/ax650.lua")
    includes("opencv/opencv-aarch64-gnu.lua")
    includes("toolchains/aarch64-gnu.lua")
elseif is_config("chip", "ax630c") then
    includes("bsp_sdk/ax620e.lua")
    add_requires("ax620e")
elseif is_config("chip", "ax620q") then
    includes("bsp_sdk/ax620e.lua")
    add_requires("ax620e")
elseif is_config("chip", "ax620a") then
    includes("bsp_sdk/ax620.lua")
    add_requires("ax620")
elseif is_config("chip", "ax620u") then
    includes("bsp_sdk/ax620.lua")
    add_requires("ax620")

-- TODO
elseif is_config("chip", "ax630a") then
    includes("bsp_sdk/ax650.lua")
    add_requires("ax650")
elseif is_config("chip", "ax637") then
    includes("bsp_sdk/ax650.lua")
    add_requires("ax650")

else
end
