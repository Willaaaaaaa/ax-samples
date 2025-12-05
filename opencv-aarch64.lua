package("opencv-aarch64")
    add_urls("https://github.com/AXERA-TECH/ax-samples/releases/download/v0.1/opencv-aarch64-linux-gnu-gcc-7.5.0.zip")

    add_versions("4.5.5", "6f9bc791d4501ebdd698b7bcbf4dbab58d98a6a030bf2cfdf5866064cd9a0b2f")

    add_syslinks("pthread", "dl")

    on_install("@linux|x86_64", function (package)
        os.cp("*|share|build_opencv_aarch64.sh", package:installdir())
        package:add("includedirs", "include/opencv4")

        package:add("linkdirs", "lib")
        package:add("linkdirs", "lib/opencv4/3rdparty")
        for _, lib_file in ipairs(os.files(package:installdir("lib/*.a"))) do
            local lib_name = path.basename(lib_file):match("lib(.+)")
            package:add("links", lib_name)
        end
        for _, lib_file in ipairs(os.files(package:installdir("lib/opencv4/3rdparty/*.a"))) do
            local lib_name = path.basename(lib_file):match("lib(.+)")
            package:add("links", lib_name)
        end
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
