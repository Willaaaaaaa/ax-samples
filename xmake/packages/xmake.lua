local chip_val = get_config("chip")
if chip_val == "ax650" or chip_val == "ax630c" or chip_val == "ax637" then
    if chip_val ~= "ax637" then
        local bsp_sdk = chip_val == "ax650" and "ax650" or "ax620e"
        includes("bsp_sdk/" .. bsp_sdk .. ".lua")
    end
    includes("opencv/opencv-aarch64-gnu.lua")
    includes("toolchains/aarch64-gnu.lua")
elseif chip_val == "ax620q" then
    includes("bsp_sdk/ax620e.lua")
    includes("opencv/opencv-arm-uclibc.lua")
    includes("toolchains/arm-uclibc.lua")
elseif chip_val == "ax620" then
    includes("bsp_sdk/ax620.lua")
    includes("opencv/opencv-arm-gnueabihf.lua")
    includes("toolchains/arm-gnueabihf.lua")

-- TODO
elseif chip_val == "ax630a" then
    -- FAE
else
end
