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

toolchain("gcc-arm")
    set_kind("standalone")
    set_cross("aarch64-none-linux-gnu-")
toolchain_end()

includes("examples")

includes("gcc-arm-9.2.lua", "opencv-aarch64.lua")
add_requires("gcc-arm-9.2", "opencv-aarch64")
set_toolchains("gcc-arm@gcc-arm-9.2")

rule("build_summary")
    set_kind("project")
    after_build(function (opt)
        import("core.project.config")
        import("core.project.project")

        local plat = config.get("plat") or "unknown"
        local arch = config.get("arch") or "unknown"
        local mode = config.get("mode") or "unknown"
        local chip = config.get("chip") or "default"
        local build_dir = config.get("builddir") or "default"
        local install_dir = config.get("installdir") or "default"

        local function print_info(key, value, default)
            value = value or default or "nil"
            cprint("${green}  - %-25s: ${clear}%s", key, value)
        end

        local function print_separator()
            cprint("${dim}%-s${clear}", string.rep("-", 50))
        end

        cprint("\n${bright}Build Configuration Summary${clear}")
        print_separator()

        cprint("${cyan}Xmake Information:${clear}")
        print_info("Version", xmake.version())
        print_info("Build Mode", mode)
        print_info("Target Platform", plat)
        print_info("Target Architecture", arch)
        print_info("Bus Width", arch:find("64") and "64-bit" or "32-bit")

        cprint("${cyan}Compiler Information:${clear}")
        if plat == "cross" then
            print_info("Cross Compiling", "Yes")
        else
            print_info("Cross Compiling", "No (Native Build)")
        end

        local cc_name = "unknown"
        local targets = project.targets()
        for _, proj_target in pairs(targets) do
            local cc_tool = proj_target:tool("cc")
            if cc_tool then
                cc_name = path.basename(cc_tool)
                break
            end
        end
        print_info("C Compiler", cc_name)

        cprint("${cyan}Project Information:${clear}")
        print_info("Project Name", project.name())
        print_info("Target Chip", chip)
        print_info("Build Directory", build_dir)
        print_info("Install Directory", install_dir)

        local host = os.host()
        local host_arch = os.arch()
        print_info("Host System", host)
        print_info("Host Architecture", host_arch)

        print_separator()
    end)
rule_end()
