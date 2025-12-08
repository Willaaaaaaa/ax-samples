# 使用 Xmake 进行交叉编译

https://github.com/Willaaaaaaa/ax-samples/tree/xmake 这个分支特意提供了在 linux 本机下为 AX650, AX620E, AX620 交叉编译的方法。能够实现 OpenCV, bsp_sdk 的自动拉取以及编译器、工具链的自动选择。

## 使用前提

- 选择在 Linux 上进行交叉编译，而非本地编译
- 目标板子在 AX650, AX620E, AX620 这个范围中
- 能够正常访问 github 进行 OpenCV, bsp_sdk 的拉取

## 使用方式：

1. 安装 Xmake
这里推荐使用官方安装脚本进行安装，请注意 Xmake 在 root 下安装的话需要额外的配置，请查看[文档](https://xmake.io/zh/guide/quick-start.html#installation)
```bash
curl -fsSL https://xmake.io/shget.text | bash
```

2. 克隆仓库
```bash
git clone https://github.com/Willaaaaaaa/ax-samples.git
git checkout xmake
```

3. 直接进行构建
```bash
xmake f --chip=ax650 --yes
xmake build
```

讲解：
- `xmake f --chip=ax650 --yes` 可以使用 `xmake f --menu` 进行代替，后者提供了一个可视化的 cli 界面供用户进行目标板子的选取。
- `xmake f` 表示进行构建之前的配置， chip 为该项目中的一个 option ，可选值为 `"ax650", "ax630c", "ax620q", "ax620", "ax637"`
- `xmake f` 在进行配置的同时会拉取 OpenCV, bsp_sdk, toolchain 包，这里已经预设好了，传递的 `--yes` 参数可以不经确认直接进行拉取
