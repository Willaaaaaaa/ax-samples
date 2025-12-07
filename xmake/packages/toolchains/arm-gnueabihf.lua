package("arm-gnueabihf")
    -- AX620A, AX620U
    set_kind("toolchain")

    add_urls("http://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz")

    add_versions("7.5.0", "abf877f021c5f094d396bac4d842ed6f13aecbf4c477fc5825cf2d8b1fe3ef22")

    on_install("@linux|x86_64", function (package)
        os.cp("*", package:installdir())
    end)

    on_test(function (package)
        os.vrun("arm-linux-gnueabihf-gcc --version")
    end)
