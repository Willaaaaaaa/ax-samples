package("opencv-aarch64-gnu")
    -- AX650A, AX650N, AX630C, AX637
    add_urls("https://github.com/AXERA-TECH/ax-samples/releases/download/v0.1/opencv-aarch64-linux-gnu-gcc-7.5.0.zip")

    add_versions("4.5.5", "6f9bc791d4501ebdd698b7bcbf4dbab58d98a6a030bf2cfdf5866064cd9a0b2f")

    add_syslinks("pthread", "dl")

    -- set_policy("package.install_always", true)
    on_install("@linux", function (package)
        os.cp("include/**", package:installdir("include"))
        os.cp("lib/**", package:installdir("lib"))
        package:add("includedirs", "include/opencv4")

        package:add("linkdirs", "lib")
        package:add("linkdirs", "lib/opencv4/3rdparty")
        package:add("links", "opencv_highgui", "opencv_videoio", "opencv_imgcodecs", "opencv_imgproc", "opencv_core", "tegra_hal", "ittnotify", "libwebp", "libtiff", "libpng", "libopenjp2", "libjpeg-turbo", "zlib")
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <iostream>
            void test(int argc, char** argv) {
                cv::CommandLineParser parser(argc, argv, "{help h||show help message}");
                if (parser.has("help")) {
                    parser.printMessage();
                }
                cv::Mat image(3, 3, CV_8UC1);
                std::cout << CV_VERSION << std::endl;
            }
        ]]}, {configs = {languages = "c++11"}, includes = "opencv2/opencv.hpp"}))
    end)
