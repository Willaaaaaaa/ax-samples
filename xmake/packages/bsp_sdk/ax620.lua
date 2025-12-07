package("ax620")
    -- AX620A, AX620U
    set_homepage("https://github.com/AXERA-TECH/ax650n_bsp_sdk")
    set_description("linux bsp app & sample for axpi pro (ax650n)")

    add_urls("https://github.com/AXERA-TECH/ax-samples/releases/download/v0.3/arm_axpi_r1.22.2801.zip")

    add_versions("0.3", "318b88ed490ed956d0c01df8bafea1dc6b36bde41d578281b0063963bd6c5553")

    on_install(function (package)
        os.cp("msp/out/*", package:installdir())
        package:add("ldflags", "-Wl,--allow-shlib-undefined")
        package:add("ldflags", "-Wl,-rpath," .. package:installdir("lib"))
    end)

    on_test(function (package)
        assert(package:has_cfuncs("AX_ENGINE_Init", {includes = "ax_engine_api.h"}))
    end)
