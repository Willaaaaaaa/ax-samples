package("gcc-arm-9.2")
    set_kind("toolchain")
    set_homepage("https://developer.arm.com/documentation/109388/9-2-2019-12/")
    set_description("GNU Toolchain for the AArch64 Architecture (9.2-2019.12)")

    add_urls("https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz")
    set_policy("package.download.http_headers", {"User-Agent: curl/8.5.0"})

    add_versions("9.2", "8dfe681531f0bd04fb9c53cf3c0a3368c616aa85d48938eebe2b516376e06a66")

    -- set_policy("package.install_always", true)
    on_install("@linux|x86_64", function (package)
        os.cp("*", package:installdir())
    end)

    on_test(function (package)
        os.vrun("aarch64-none-linux-gnu-gcc --version")
    end)
