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
    set_values("ax650", "ax620e", "ax620", "ax630", "ax637")
    set_showmenu(true)
    set_description("Set the target chip")
    after_check(function (option)
        option:add("defines", "AXERA_TARGET_CHIP_" .. option:value():upper())
    end)
option_end()
add_options("chip")

includes("xmake", "examples")

-- TODO: other chips
toolchain("gcc-arm")
    set_kind("standalone")
    set_cross("aarch64-none-linux-gnu-")
toolchain_end()
add_requires("aarch64-gnu")
set_toolchains("gcc-arm@aarch64-gnu")
add_requires("ax650", "opencv-aarch64-gnu")
