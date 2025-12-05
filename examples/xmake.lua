-- Add current directory to includes
add_includedirs(".")

-- Add subdirectories based on target chip
local target_chip = get_config("chip")
if target_chip == "ax650" then
    includes("../ax650n_bsp_sdk.lua")
    add_requires("ax650n_bsp_sdk")
    includes("ax650")
elseif target_chip == "ax630c" then
    includes("ax620e")
elseif target_chip == "ax620q" then
    includes("ax620e")
elseif target_chip == "ax620a" then
    includes("ax620")
elseif target_chip == "ax630a" then
    includes("ax620")
elseif target_chip == "ax637" then
    includes("ax637")
end
