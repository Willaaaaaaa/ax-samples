package("arm-uclibc")
    -- AX620Q
    set_kind("toolchain")

    add_urls("https://github.com/AXERA-TECH/ax620q_bsp_sdk/releases/download/v2.0.0/arm-AX620E-linux-uclibcgnueabihf_V3_20240320.tgz")

    add_versions("v2.0.0", "6b9491acf2f036b8a71cf6adfad88406f8bfdc4805a7a2456793c688c101850b")

    on_install("@linux|x86_64", function (package)
        os.cp("*", package:installdir())
    end)

    on_test(function (package)
        os.vrun("arm-AX620E-linux-uclibcgnueabihf-gcc --version")
    end)
