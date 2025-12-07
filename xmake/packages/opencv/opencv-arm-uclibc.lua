package("opencv-arm-uclibc")
    -- AX620Q
    add_urls("https://github.com/AXERA-TECH/ax-samples/releases/download/v0.6/opencv-arm-uclibc-linux.zip")

    add_versions("4.5.5", "f7c5ecf68ba281548803c9dc0abf748fa415d9910bb87851b42f76c717f4a6e3")

    add_syslinks("pthread", "dl")

    on_install("@linux", function (package)
        os.cp("include/**", package:installdir("include"))
        os.cp("lib/**", package:installdir("lib"))
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
