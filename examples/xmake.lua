-- Add current directory to includes
add_includedirs(".")

-- Add subdirectories based on target chip
local chip_val = get_config("chip")
if chip_val == "ax650" then
    includes("ax650")
elseif chip_val == "ax630c" then
    includes("ax620e")
elseif chip_val == "ax620q" then
    includes("ax620e")
elseif chip_val == "ax620a" then
    includes("ax620")
elseif chip_val == "ax630a" then
    includes("ax620")
elseif chip_val == "ax637" then
    includes("ax637")
end
