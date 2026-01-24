# AutoIO - IO MUX Verilog自动生成工具

## 简介

`autoio.py` 是一个根据IO MUX表格自动生成Verilog代码的Python脚本。该工具可以解析Excel表格中的PAD配置信息，自动生成包含IO复用逻辑的Verilog模块。

## 功能特性

- 自动解析Excel表格，动态识别列位置
- 支持IO和CRYSTAL两种PAD类型
- 自动生成MUX选择逻辑
- 支持Function0~Function3、Test Mode、Scan Mode六种模式
- 自动检测重复信号并报警告
- 生成格式化的Verilog代码，包含对齐的注释和端口定义

## 依赖安装

```bash
pip install openpyxl
```

## 使用方法

```bash
python autoio.py -i <输入表格路径> -o <输出Verilog路径>
```

### 参数说明

| 参数 | 说明 | 示例 |
|------|------|------|
| `-i, --input` | 输入Excel表格路径 | `SOC_iomux.xlsx` |
| `-o, --output_path` | 输出Verilog文件路径（含模块名） | `output/io_top.v` |

### 使用示例

```bash
python autoio.py -i SOC_iomux.xlsx -o io_top.v
```

## 输入表格格式

表格需要包含两行表头：

### 第一行表头（必需列）
- `PAD Name` - PAD名称
- `Direction` - 方向（EW或NS）
- `TYPE` - 类型（IO或CRYSTAL）
- `Digital IO` - 是否生成代码（Y/N）

### 第二行表头（功能定义）
- `Function 0` + `I/O` - 功能0名称及IO类型
- `Function 1` + `I/O` - 功能1名称及IO类型
- `Function 2` + `I/O` - 功能2名称及IO类型
- `Function 3` + `I/O` - 功能3名称及IO类型
- `test_mode` + `I/O` - 测试模式名称及IO类型
- `scan_mode` + `I/O` - 扫描模式名称及IO类型

### IO类型说明
- `I` - 输入
- `O` - 输出
- `IO` - 双向

### 表格示例

| PAD Name | Direction | TYPE | Digital IO | Function 0 | I/O | Function 1 | I/O | test_mode | I/O | scan_mode | I/O |
|----------|-----------|------|------------|------------|-----|------------|-----|-----------|-----|-----------|-----|
| JTAG_TCK | NS | IO | y | jtag_tck | I | | | ijtag_tck | I | | |
| SMDATA | EW | IO | y | smdata | IO | | | | | edt_ch_out1 | O |
| XI | EW | CRYSTAL | y | clk_25m | I | | | | | | |
| XO | EW | CRYSTAL | y | | O | | | | | | |

## PAD类型说明

### IO类型
- 普通双向IO，支持多功能复用
- 根据Direction自动设置PHY_DIR参数（EW=0, NS=1）
- 自动生成pad_in、pad_out、pad_oen信号及MUX逻辑

### CRYSTAL类型
- 晶振IO，必须占两行（XIN和XOUT）
- 根据I/O列判断哪个是XIN（I）哪个是XOUT（O）
- 无需MUX逻辑

## 模式选择编码

生成的Verilog使用localparam定义模式选择：

```verilog
localparam SEL_FUNC0 = 4'b0000;  // function 0
localparam SEL_FUNC1 = 4'b0001;  // function 1
localparam SEL_FUNC2 = 4'b0010;  // function 2
localparam SEL_FUNC3 = 4'b0011;  // function 3
localparam SEL_SCAN  = 4'b0100;  // scan mode
localparam SEL_TEST  = 4'b1000;  // test mode
```

## MUX优先级

当多个模式同时有效时，MUX判断优先级从高到低：
1. Scan Mode (最高)
2. Test Mode
3. Function 3
4. Function 2
5. Function 1
6. Function 0 (最低)

## 输出文件结构

生成的Verilog文件包含以下部分：

1. **文件头注释** - 包含文件名、描述、生成时间等信息
2. **模式编码说明** - pad_sel编码定义
3. **模块端口定义** - 按类别分组（PAD定义、IO配置、IO选择、各功能信号）
4. **localparam定义** - 模式选择的本地参数
5. **PAD实例化** - 每个PAD的注释块、wire声明、MUX逻辑、模块实例化

## 注意事项

1. CRYSTAL类型必须占两行，否则报错
2. Direction必须为EW或NS，否则报错
3. 相同信号复用多个PAD时，会报Warning并只生成一次端口定义
4. 只有Digital IO列为Y的行才会生成代码

## 关联文件

- `xs_io.v` - IO类型PAD的wrapper模块
- `xs_crystal_io.v` - CRYSTAL类型PAD的wrapper模块
- `io_wrapper.v` - IO物理层wrapper
- `crystal_io_wrapper.v` - CRYSTAL物理层wrapper

## 作者
czz
