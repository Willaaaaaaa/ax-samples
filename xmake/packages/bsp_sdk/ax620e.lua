package("ax620e")
    -- AX620Q, AX630C
    set_homepage("https://github.com/AXERA-TECH/ax620e_bsp_sdk")
    set_description("linux bsp app & sample for axpi pro (ax650n)")

    add_urls("https://github.com/AXERA-TECH/ax620e_bsp_sdk/archive/refs/tags/$(version).tar.gz",
             "https://github.com/AXERA-TECH/ax620e_bsp_sdk.git")

    add_versions("v2.0.0_P7", "adfe5fda41b1aac131a2b2618a823b9c5041c486dfa725ce7fc0e9c1331cca65")

    on_install(function (package)
        os.cp("msp/out/arm_uclibc/*", package:installdir())
        package:add("ldflags", "-Wl,--allow-shlib-undefined")
        package:add("ldflags", "-Wl,-rpath," .. package:installdir("lib"))
    end)

    on_test(function (package)
        assert(package:has_cfuncs("AX_ENGINE_Init", {includes = "ax_engine_api.h"}))
    end)
