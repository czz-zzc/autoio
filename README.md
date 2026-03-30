# AutoIO - IO MUX Verilog自动生成工具

## 简介

`autoio.py` 是一个根据IO MUX表格自动生成Verilog代码的Python脚本。该工具可以解析Excel表格中的PAD配置信息，自动生成包含IO复用逻辑的Verilog模块。

## 功能特性

- 自动解析Excel表格，动态识别列位置
- 支持IO和CRYSTAL两种PAD类型
- 根据 `CELL NAME` 列自动推导并校验 PHY_DIR、LMIT_SLEW_RATE、SCHMITT_TRIGGER 参数
- 自动生成MUX选择逻辑
- 支持Function0~Function3、Test Mode、Scan Mode六种模式
- 错误信息红色高亮显示，遇到错误立即退出

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
- `TYPE` - 类型（IO或CRYSTAL/CRSTAL）
- `Digital IO` - 是否生成代码（Y/N，只处理Y的行）
- `CELL NAME` - 物理IO单元型号（用于自动推导参数并校验）

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

| PAD Name | Direction | TYPE | Digital IO | CELL NAME | Function 0 | I/O | Function 1 | I/O | test_mode | I/O | scan_mode | I/O |
|----------|-----------|------|------------|-----------|------------|-----|------------|-----|-----------|-----|-----------|-----|
| JTAG_TCK | NS | IO | y | PRDWUW1216DGH_V | jtag_tck | I | | | ijtag_tck | I | | |
| SMDATA | EW | IO | y | PDDWUW0408SDGH_H | smdata | IO | | | | | edt_ch_out1 | O |
| XI | EW | CRYSTAL | y | PDXOEDG8E_H | clk_25m | I | | | | | | |
| XO | EW | CRYSTAL |  | PDXOEDG8E_H | | O | | | | | | |

## CELL NAME 说明

脚本根据 `CELL NAME` 自动推导以下三个 `xs_io` parameter，并校验表格中的 TYPE / Direction 是否一致：

| CELL NAME | TYPE | LMIT_SLEW_RATE | SCHMITT_TRIGGER | PHY_DIR |
|-----------|------|----------------|------------------|---------|
| PDDWUW0408DGH_H | IO | 0 | 0 | 0 (EW) |
| PDDWUW0408DGH_V | IO | 0 | 0 | 1 (NS) |
| PDDWUW0408SDGH_H | IO | 0 | 1 | 0 (EW) |
| PDDWUW0408SDGH_V | IO | 0 | 1 | 1 (NS) |
| PRDWUW1216DGH_H | IO | 1 | 0 | 0 (EW) |
| PRDWUW1216DGH_V | IO | 1 | 0 | 1 (NS) |
| PRDWUW1216SDGH_H | IO | 1 | 1 | 0 (EW) |
| PRDWUW1216SDGH_V | IO | 1 | 1 | 1 (NS) |
| PDXOEDG8E_H | CRYSTAL | - | - | 0 (EW) |
| PDXOEDG8E_V | CRYSTAL | - | - | 1 (NS) |

> 后缀 `_H` 对应 EW 方向（PHY_DIR=0），`_V` 对应 NS 方向（PHY_DIR=1）

## PAD类型说明

### IO类型
- 普通双向IO，支持多功能复用
- 根据 CELL NAME 自动设置 PHY_DIR / LMIT_SLEW_RATE / SCHMITT_TRIGGER 参数
- 自动生成 `pad_in`、`pad_out`、`pad_oen` 信号及 MUX 逻辑

### CRYSTAL类型
- 晶振IO，必须占两行（XIN和XOUT），第二行 Digital IO 可为空
- 根据 I/O 列判断哪个是 XIN（I）哪个是 XOUT（O）
- 无需 MUX 逻辑

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
1. Scan Mode（最高）
2. Test Mode
3. Function 3
4. Function 2
5. Function 1
6. Function 0（最低）

## 输出文件结构

生成的Verilog文件包含以下部分：

1. **文件头注释** - 包含文件名、描述、生成时间等信息和 pad_sel 编码说明
2. **模块端口定义** - 按类别分组：PAD定义、IO配置、IO选择、各功能信号
3. **localparam定义** - 模式选择的本地参数
4. **PAD实例化** - 每个PAD的注释块（含CELL NAME、参数信息）、wire声明、MUX逻辑、模块实例化

### 实例化注释块示例

```verilog
//----------------------------------------------------------------
// PAD_NAME         :JTAG_TCK
// TYPE             :IO
// CELL_NAME        :PRDWUW1216DGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER :0
//------------------------------------------
// Function0        :jtag_tck       IO:I
// Function1        :None           IO:None
// ...
//----------------------------------------------------------------
```

## 错误处理

所有错误信息以**红色**显示并立即退出（exit code 1）：

- CELL NAME 未知或不在支持列表中
- TYPE / Direction 与 CELL NAME 不一致
- CRYSTAL 类型不足两行
- Direction 不是 EW 或 NS
- 信号重复定义
- 未找到任何需要生成的PAD（Digital IO=Y）
- 输入文件不存在

## 注意事项

1. CRYSTAL 类型必须占两行，第二行 Digital IO 可为空
2. Direction 必须为 EW 或 NS
3. CELL NAME 列缺失时跳过参数推导，但不报错
4. TYPE 支持 `CRSTAL` 拼写容错（自动纠正为 `CRYSTAL`）

## 关联文件

- `xs_io.v` - IO类型PAD的wrapper模块（包含PHY_DIR / LMIT_SLEW_RATE / SCHMITT_TRIGGER参数）
- `xs_crystal_io.v` - CRYSTAL类型PAD的wrapper模块
- `io_wrapper.v` - IO物理层wrapper
- `crystal_io_wrapper.v` - CRYSTAL物理层wrapper

## 作者
czz