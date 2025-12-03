package("opencv-aarch64")
    add_urls("https://github.com/AXERA-TECH/ax-samples/releases/download/v0.1/opencv-aarch64-linux-gnu-gcc-$(version).zip")

    add_versions("7.5.0", "6f9bc791d4501ebdd698b7bcbf4dbab58d98a6a030bf2cfdf5866064cd9a0b2f")

    -- set_policy("package.install_always", true)
    on_install("linux", function (package)
        os.cp("*|build_opencv_aarch64.sh", package:installdir())
        os.mv(package:installdir("include/opencv4/opencv2"), package:installdir("include"))
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <opencv2/opencv.hpp>
            void test() {
                cv::Mat img(3, 3, CV_8UC1);
            }
        ]]})) 
    end)
