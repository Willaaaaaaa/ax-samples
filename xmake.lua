set_project("AXERA-Samples")

set_xmakever("3.0.4")

add_rules("mode.debug", "mode.release")
add_rules("build_summary")
add_rules("plugin.compile_commands.autoupdate", {outputdir = "build"})

set_defaultmode("release")
if is_mode("release") then
    set_optimize("fast")  -- use -O1
    set_warnings("all")   -- use -Wall
    set_strip("all")
    add_cxflags("-fPIC", "-Wunused-function")
end

option("chip")
    set_default("ax650")
    set_values("ax650", "ax630c", "ax620q", "ax620", "ax637")
    set_showmenu(true)
    set_description("Set the target chip")
    after_check(function (option)
        option:add("defines", "AXERA_TARGET_CHIP_" .. option:value():upper())
    end)
option_end()
add_options("chip")

includes("xmake", "examples")

local chip_val = get_config("chip")

-- TODO: other chips
if chip_val == "ax650" or chip_val == "ax630c" or chip_val == "ax637" then
    toolchain("cross-aarch64")
        set_kind("standalone")
        set_cross("aarch64-none-linux-gnu-")
    toolchain_end()
    add_requires("aarch64-gnu", "opencv-aarch64-gnu")
    set_toolchains("cross-aarch64@aarch64-gnu")
    if chip_val ~= "ax637" then
        local bsp_sdk = chip_val == "ax650" and "ax650" or "ax620e"
        add_requires(bsp_sdk, (chip_val == "ax650" and {} or {configs = {target = "ax630c"}}))
    else
        -- ax637->FAE
    end
elseif chip_val == "ax620q" then
    toolchain("cross-arm-uclibc")
        set_kind("standalone")
        set_cross("arm-AX620E-linux-uclibcgnueabihf-")
    toolchain_end()
    add_requires("arm-uclibc", "opencv-arm-uclibc")
    add_requires("ax620e", {configs = {target = "ax620q"}})
    set_toolchains("cross-arm-uclibc@arm-uclibc")
elseif chip_val == "ax620" then
    toolchain("cross-arm-glibc")
        set_kind("standalone")
        set_cross("arm-linux-gnueabihf-")
    toolchain_end()
    add_requires("arm-gnueabihf", "opencv-arm-gnueabihf", "ax620")
    set_toolchains("cross-arm-glibc@arm-gnueabihf")
else
    -- ax630
end
