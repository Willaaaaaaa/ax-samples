package("ax650")
    -- AX650A, AX650N
    set_homepage("https://github.com/AXERA-TECH/ax650n_bsp_sdk")
    set_description("linux bsp app & sample for axpi pro (ax650n)")

    add_urls("https://github.com/AXERA-TECH/ax650n_bsp_sdk/archive/refs/tags/$(version).tar.gz",
             "https://github.com/AXERA-TECH/ax650n_bsp_sdk.git")

    add_versions("v1.45.0_p39", "7f2ece72a881dcff0d11171f72c43086ded5ab64af1a970d3507fb6414b57390")

    set_policy("package.install_always", true)
    on_install(function (package)
        os.cp("msp/out/*", package:installdir())
        package:add("ldflags", "-Wl,--allow-shlib-undefined")
        package:add("ldflags", "-Wl,-rpath," .. package:installdir("lib"))
    end)

    on_test(function (package)
        assert(package:has_cfuncs("AX_ENGINE_Init", {includes = "ax_engine_api.h"}))
    end)
