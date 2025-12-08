package("ax620e")
    -- AX620Q, AX630C
    set_homepage("https://github.com/AXERA-TECH/ax620e_bsp_sdk")
    set_description("linux bsp app & sample for axpi pro (ax650n)")

    add_urls("https://github.com/AXERA-TECH/ax620e_bsp_sdk/archive/refs/tags/$(version).tar.gz",
             "https://github.com/AXERA-TECH/ax620e_bsp_sdk.git")

    add_versions("v2.0.0_P7", "adfe5fda41b1aac131a2b2618a823b9c5041c486dfa725ce7fc0e9c1331cca65")

    add_configs("target", {description = "ax620q or ax630c", default = "unspecified", type = "string", values = {"unspecified", "ax620q", "ax630c"}})

    if on_check then
        on_check(function (package)
            if package:config("target") == "unspecified" then
                raise("You need to specify a chip value (ax620q or ax630c) for ax620e_bsp_sdk")
            end
        end)
    end

    -- set_policy("package.install_always", true)
    on_install(function (package)
        local chip_val = package:config("target") == "ax620q" and "arm_uclibc" or "arm64_glibc"
        os.cp("msp/out/" .. chip_val .. "/*", package:installdir())
        package:add("ldflags", "-Wl,--allow-shlib-undefined")
        package:add("ldflags", "-Wl,-rpath," .. package:installdir("lib"))
    end)

    on_test(function (package)
        assert(package:has_cfuncs("AX_ENGINE_Init", {includes = "ax_engine_api.h"}))
    end)
