#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Auto IO Verilog Generator
根据IO MUX表格自动生成Verilog代码
"""

import argparse
import os
import sys
from dataclasses import dataclass, field
from datetime import datetime
from typing import List, Optional, Tuple
import openpyxl


@dataclass
class FunctionInfo:
    """功能信息结构体"""
    name: str = ""      # 功能名称
    io_type: str = ""   # IO类型: I/O/IO/None


@dataclass
class PadInfo:
    """PAD信息结构体"""
    pad_name: str = ""
    direction: str = ""  # EW or NS
    pad_type: str = ""   # IO or CRYSTAL
    digital_io: str = ""
    function0: FunctionInfo = field(default_factory=FunctionInfo)
    function1: FunctionInfo = field(default_factory=FunctionInfo)
    function2: FunctionInfo = field(default_factory=FunctionInfo)
    function3: FunctionInfo = field(default_factory=FunctionInfo)
    test_mode: FunctionInfo = field(default_factory=FunctionInfo)
    scan_mode: FunctionInfo = field(default_factory=FunctionInfo)
    
    # For CRYSTAL type, store the second pad info
    second_pad_name: str = ""
    second_io_type: str = ""


class AutoIOGenerator:
    """自动IO Verilog生成器"""
    
    # pad_sel 定义 - 编码值
    PAD_SEL_VALUE = {
        'function0': "4'b0000",
        'function1': "4'b0001",
        'function2': "4'b0010",
        'function3': "4'b0011",
        'scan_mode': "4'b0100",
        'test_mode': "4'b1000",
    }
    
    # pad_sel 定义 - localparam名称
    PAD_SEL = {
        'function0': "SEL_FUNC0",
        'function1': "SEL_FUNC1",
        'function2': "SEL_FUNC2",
        'function3': "SEL_FUNC3",
        'scan_mode': "SEL_SCAN",
        'test_mode': "SEL_TEST",
    }
    
    def __init__(self, input_file: str, output_path: str):
        self.input_file = input_file
        self.output_path = output_path
        self.pads: List[PadInfo] = []
        self.module_name = os.path.splitext(os.path.basename(output_path))[0]
        # 列索引映射 (动态解析)
        self.col_map = {}
        
    def get_cell_value(self, row, col_idx) -> str:
        """获取单元格值，处理None和空值"""
        if col_idx is None or col_idx < 0:
            return ""
        try:
            val = row[col_idx].value
            if val is None:
                return ""
            return str(val).strip()
        except IndexError:
            return ""
    
    def find_column_indices(self, header_row1, header_row2):
        """根据表头自动查找列索引"""
        col_map = {}
        
        # 遍历第一行表头
        for col_idx, cell in enumerate(header_row1):
            val = cell.value
            if val is None:
                continue
            val = str(val).strip().upper()
            
            # 基本信息列
            if 'PAD' in val and 'NAME' in val:
                col_map['pad_name'] = col_idx
            elif val == 'DIRECTION':
                col_map['direction'] = col_idx
            elif val == 'TYPE':
                col_map['type'] = col_idx
            elif 'DIGITAL' in val and 'IO' in val:
                col_map['digital_io'] = col_idx
        
        # 遍历第二行表头查找Function和Mode相关列
        for col_idx, cell in enumerate(header_row2):
            val = cell.value
            if val is None:
                continue
            val_str = str(val).strip().lower()
            
            # Function 0-3
            if 'function' in val_str and '0' in val_str:
                col_map['func0_name'] = col_idx
            elif 'function' in val_str and '1' in val_str:
                col_map['func1_name'] = col_idx
            elif 'function' in val_str and '2' in val_str:
                col_map['func2_name'] = col_idx
            elif 'function' in val_str and '3' in val_str:
                col_map['func3_name'] = col_idx
            # Test mode
            elif 'test' in val_str and 'mode' in val_str:
                col_map['test_name'] = col_idx
            # Scan mode
            elif 'scan' in val_str and 'mode' in val_str:
                col_map['scan_name'] = col_idx
            # I/O列 - 检查前一列是否是function/test/scan
            elif val_str in ['i/o', 'io']:
                # 查找这是哪个function的I/O列
                # I/O列紧跟在function/test/scan列后面
                if col_idx > 0:
                    prev_val = header_row2[col_idx - 1].value
                    if prev_val:
                        prev_str = str(prev_val).strip().lower()
                        if 'function' in prev_str and '0' in prev_str:
                            col_map['func0_io'] = col_idx
                        elif 'function' in prev_str and '1' in prev_str:
                            col_map['func1_io'] = col_idx
                        elif 'function' in prev_str and '2' in prev_str:
                            col_map['func2_io'] = col_idx
                        elif 'function' in prev_str and '3' in prev_str:
                            col_map['func3_io'] = col_idx
                        elif 'test' in prev_str and 'mode' in prev_str:
                            col_map['test_io'] = col_idx
                        elif 'scan' in prev_str and 'mode' in prev_str:
                            col_map['scan_io'] = col_idx
        
        # 验证必要列是否存在
        required_cols = ['pad_name', 'direction', 'type', 'digital_io']
        missing = [col for col in required_cols if col not in col_map]
        if missing:
            print(f"Error: 表头中缺少必要列: {missing}")
            sys.exit(1)
        
        self.col_map = col_map
        print(f"列映射: {col_map}")
    
    def parse_excel(self):
        """解析Excel表格"""
        try:
            wb = openpyxl.load_workbook(self.input_file)
            ws = wb.active
        except Exception as e:
            print(f"Error: 无法打开文件 {self.input_file}: {e}")
            sys.exit(1)
        
        rows = list(ws.iter_rows())
        if len(rows) < 3:
            print("Error: 表格行数不足，至少需要2行表头+1行数据")
            sys.exit(1)
        
        # 解析表头，自动查找列索引
        header_row1 = rows[0]
        header_row2 = rows[1]
        self.find_column_indices(header_row1, header_row2)
        
        # 跳过前两行表头，从第3行开始处理数据
        data_rows = rows[2:]
        
        i = 0
        while i < len(data_rows):
            row = data_rows[i]
            
            # 获取Digital IO列的值
            digital_io = self.get_cell_value(row, self.col_map.get('digital_io'))
            pad_type = self.get_cell_value(row, self.col_map.get('type')).upper()
            pad_name = self.get_cell_value(row, self.col_map.get('pad_name'))
            
            # 只处理Digital IO为Y的行
            if digital_io.upper() != 'Y':
                # 检查是否是CRYSTAL第二行（被前一行跳过的）
                i += 1
                continue
            
            print(f"处理PAD: {pad_name}, TYPE: {pad_type}, Digital IO: {digital_io}")
            
            pad_info = PadInfo()
            pad_info.pad_name = self.get_cell_value(row, self.col_map.get('pad_name'))
            pad_info.direction = self.get_cell_value(row, self.col_map.get('direction'))
            pad_info.pad_type = self.get_cell_value(row, self.col_map.get('type')).upper()
            # 兼容CRSTAL拼写错误
            if pad_info.pad_type == 'CRSTAL':
                pad_info.pad_type = 'CRYSTAL'
            pad_info.digital_io = digital_io
            
            # 解析Function信息
            pad_info.function0 = FunctionInfo(
                name=self.get_cell_value(row, self.col_map.get('func0_name')),
                io_type=self.get_cell_value(row, self.col_map.get('func0_io')).upper()
            )
            pad_info.function1 = FunctionInfo(
                name=self.get_cell_value(row, self.col_map.get('func1_name')),
                io_type=self.get_cell_value(row, self.col_map.get('func1_io')).upper()
            )
            pad_info.function2 = FunctionInfo(
                name=self.get_cell_value(row, self.col_map.get('func2_name')),
                io_type=self.get_cell_value(row, self.col_map.get('func2_io')).upper()
            )
            pad_info.function3 = FunctionInfo(
                name=self.get_cell_value(row, self.col_map.get('func3_name')),
                io_type=self.get_cell_value(row, self.col_map.get('func3_io')).upper()
            )
            pad_info.test_mode = FunctionInfo(
                name=self.get_cell_value(row, self.col_map.get('test_name')),
                io_type=self.get_cell_value(row, self.col_map.get('test_io')).upper()
            )
            pad_info.scan_mode = FunctionInfo(
                name=self.get_cell_value(row, self.col_map.get('scan_name')),
                io_type=self.get_cell_value(row, self.col_map.get('scan_io')).upper()
            )
            
            # 处理CRYSTAL类型
            if pad_info.pad_type == 'CRYSTAL':
                # CRYSTAL类型必须占两行
                if i + 1 >= len(data_rows):
                    print(f"Error: CRYSTAL类型 {pad_info.pad_name} 必须占两行")
                    sys.exit(1)
                
                next_row = data_rows[i + 1]
                next_type = self.get_cell_value(next_row, self.col_map.get('type')).upper()
                # 兼容CRSTAL拼写错误
                if next_type == 'CRSTAL':
                    next_type = 'CRYSTAL'
                next_digital_io = self.get_cell_value(next_row, self.col_map.get('digital_io'))
                
                # CRYSTAL第二行也必须是CRYSTAL类型，但Digital IO可以为空或Y
                if next_type != 'CRYSTAL':
                    print(f"Error: CRYSTAL类型 {pad_info.pad_name} 必须占两行，且两行都需要是CRYSTAL类型，当前第二行类型为: {next_type}")
                    sys.exit(1)
                
                pad_info.second_pad_name = self.get_cell_value(next_row, self.col_map.get('pad_name'))
                pad_info.second_io_type = self.get_cell_value(next_row, self.col_map.get('func0_io')).upper()
                
                # 如果第一行没有direction，尝试从第二行获取
                if not pad_info.direction:
                    pad_info.direction = self.get_cell_value(next_row, self.col_map.get('direction'))
                
                i += 2  # 跳过下一行
            else:
                i += 1
            
            # 验证Direction (放在CRYSTAL处理后)
            if pad_info.direction not in ['EW', 'NS']:
                print(f"Error: PAD {pad_info.pad_name} 的Direction必须为EW或NS，当前值为: {pad_info.direction}")
                sys.exit(1)
            
            self.pads.append(pad_info)
        
        if not self.pads:
            print("Warning: 没有找到需要生成的PAD (Digital IO列为Y的行)")
    
    def get_phy_dir(self, direction: str) -> int:
        """根据Direction获取PHY_DIR值"""
        if direction == 'EW':
            return 0
        elif direction == 'NS':
            return 1
        else:
            raise ValueError(f"Invalid direction: {direction}")
    
    def generate_pad_comment(self, pad: PadInfo) -> str:
        """生成PAD注释块"""
        # 计算功能名称的最大长度用于对齐
        func_names = [
            pad.function0.name if pad.function0.name else 'None',
            pad.function1.name if pad.function1.name else 'None',
            pad.function2.name if pad.function2.name else 'None',
            pad.function3.name if pad.function3.name else 'None',
            pad.test_mode.name if pad.test_mode.name else 'None',
            pad.scan_mode.name if pad.scan_mode.name else 'None',
        ]
        max_name_len = max(len(name) for name in func_names)
        # 至少16个字符宽度
        name_width = max(max_name_len, 16)
        
        def format_func_line(prefix: str, name: str, io_type: str) -> str:
            name_str = name if name else 'None'
            io_str = io_type if io_type else 'None'
            return f"// {prefix}:{name_str:<{name_width}}IO:{io_str}"
        
        lines = []
        lines.append("//----------------------------------------------------------------")
        lines.append(f"// PAD_NAME\t:{pad.pad_name}")
        lines.append(f"// TYPE\t\t:{pad.pad_type}")
        lines.append(f"// Direction:{pad.direction}")
        lines.append(format_func_line("Function0", pad.function0.name, pad.function0.io_type))
        lines.append(format_func_line("Function1", pad.function1.name, pad.function1.io_type))
        lines.append(format_func_line("Function2", pad.function2.name, pad.function2.io_type))
        lines.append(format_func_line("Function3", pad.function3.name, pad.function3.io_type))
        lines.append(format_func_line("Test_mode", pad.test_mode.name, pad.test_mode.io_type))
        lines.append(format_func_line("Scan_mode", pad.scan_mode.name, pad.scan_mode.io_type))
        lines.append("//----------------------------------------------------------------")
        return '\n'.join(lines)
    
    def _classify_signal_by_function(self, pad: PadInfo, line: str,
                                     func0: List[str], func1: List[str], 
                                     func2: List[str], func3: List[str],
                                     test: List[str], scan: List[str]):
        """根据信号名称将端口行分类到对应的function列表"""
        # 提取信号名称 (去掉 input/output 和逗号)
        parts = line.strip().split()
        if len(parts) >= 2:
            signal_name = parts[-1].rstrip(',')
            # 去掉后缀 _i, _o, _oen
            base_name = signal_name
            for suffix in ['_i', '_o', '_oen']:
                if base_name.endswith(suffix):
                    base_name = base_name[:-len(suffix)]
                    break
            
            # 匹配到哪个function
            if pad.function0.name and base_name == pad.function0.name:
                func0.append(line)
            elif pad.function1.name and base_name == pad.function1.name:
                func1.append(line)
            elif pad.function2.name and base_name == pad.function2.name:
                func2.append(line)
            elif pad.function3.name and base_name == pad.function3.name:
                func3.append(line)
            elif pad.test_mode.name and base_name == pad.test_mode.name:
                test.append(line)
            elif pad.scan_mode.name and base_name == pad.scan_mode.name:
                scan.append(line)
            else:
                # 默认放到function0
                func0.append(line)
    
    def _classify_signal_by_function_with_check(self, pad: PadInfo, line: str,
                                     func0: List[str], func1: List[str], 
                                     func2: List[str], func3: List[str],
                                     test: List[str], scan: List[str],
                                     declared_signals: set):
        """根据信号名称将端口行分类到对应的function列表，并检测重复信号"""
        # 提取信号名称 (去掉 input/output 和逗号)
        parts = line.strip().split()
        if len(parts) >= 2:
            signal_name = parts[-1].rstrip(',')
            
            # 检测重复信号
            if signal_name in declared_signals:
                print(f"Warning: 信号 {signal_name} 在PAD {pad.pad_name} 中重复定义，已跳过")
                return
            declared_signals.add(signal_name)
            
            # 去掉后缀 _i, _o, _oen
            base_name = signal_name
            for suffix in ['_i', '_o', '_oen']:
                if base_name.endswith(suffix):
                    base_name = base_name[:-len(suffix)]
                    break
            
            # 匹配到哪个function
            if pad.function0.name and base_name == pad.function0.name:
                func0.append(line)
            elif pad.function1.name and base_name == pad.function1.name:
                func1.append(line)
            elif pad.function2.name and base_name == pad.function2.name:
                func2.append(line)
            elif pad.function3.name and base_name == pad.function3.name:
                func3.append(line)
            elif pad.test_mode.name and base_name == pad.test_mode.name:
                test.append(line)
            elif pad.scan_mode.name and base_name == pad.scan_mode.name:
                scan.append(line)
            else:
                # 默认放到function0
                func0.append(line)
    
    def has_input(self, io_type: str) -> bool:
        """判断是否有输入功能"""
        return io_type in ['I', 'IO']
    
    def has_output(self, io_type: str) -> bool:
        """判断是否有输出功能"""
        return io_type in ['O', 'IO']
    
    def get_active_functions(self, pad: PadInfo) -> List[Tuple[str, FunctionInfo, str]]:
        """获取有效的功能列表，返回 (功能类型, FunctionInfo, pad_sel值)"""
        functions = []
        
        # 按优先级从高到低排序 (scan_mode > test_mode > function3 > function2 > function1 > function0)
        # 注意：编码方式不变，只是MUX判断优先级调整
        if pad.scan_mode.name:
            functions.append(('scan_mode', pad.scan_mode, self.PAD_SEL['scan_mode']))
        if pad.test_mode.name:
            functions.append(('test_mode', pad.test_mode, self.PAD_SEL['test_mode']))
        if pad.function3.name:
            functions.append(('function3', pad.function3, self.PAD_SEL['function3']))
        if pad.function2.name:
            functions.append(('function2', pad.function2, self.PAD_SEL['function2']))
        if pad.function1.name:
            functions.append(('function1', pad.function1, self.PAD_SEL['function1']))
        if pad.function0.name:
            functions.append(('function0', pad.function0, self.PAD_SEL['function0']))
        
        return functions
    
    def generate_crystal_io(self, pad: PadInfo) -> Tuple[List[str], List[str], List[str], str]:
        """生成CRYSTAL类型的IO代码"""
        port_inputs = []
        port_outputs = []
        port_inouts = []
        instance_code = []
        
        # 判断哪个是XIN，哪个是XOUT
        xin_pad = ""
        xout_pad = ""
        
        if pad.function0.io_type == 'I':
            xin_pad = pad.pad_name
            xout_pad = pad.second_pad_name
        elif pad.function0.io_type == 'O':
            xin_pad = pad.second_pad_name
            xout_pad = pad.pad_name
        else:
            # 检查第二行
            if pad.second_io_type == 'I':
                xin_pad = pad.second_pad_name
                xout_pad = pad.pad_name
            elif pad.second_io_type == 'O':
                xin_pad = pad.pad_name
                xout_pad = pad.second_pad_name
            else:
                print(f"Error: CRYSTAL类型 {pad.pad_name} 无法确定XIN/XOUT")
                sys.exit(1)
        
        # 添加端口
        port_inputs.append(f"    input       {xin_pad},")
        port_outputs.append(f"    output      {xout_pad},")
        
        # 添加配置端口
        port_inputs.append(f"    input [3:0] pad_config_{xin_pad},")
        
        # Function0的输出信号
        if pad.function0.name:
            port_outputs.append(f"    output      {pad.function0.name}_i,")
        
        # 生成实例化代码 - 计算对齐宽度
        instance_code.append(self.generate_pad_comment(pad))
        
        port_names = ['XIN', 'XOUT', 'pad_config', 'pad_in']
        signal_names = [
            xin_pad,
            xout_pad,
            f"pad_config_{xin_pad}",
            f"{pad.function0.name}_i" if pad.function0.name else ""
        ]
        max_port_len = max(len(p) for p in port_names)
        max_signal_len = max(len(s) for s in signal_names if s)
        
        instance_code.append(f"xs_crystal_io #(")
        instance_code.append(f".PHY_DIR({self.get_phy_dir(pad.direction)})")
        instance_code.append(f")u_{xin_pad}(")
        instance_code.append(f".{'XIN':<{max_port_len}} ({xin_pad:<{max_signal_len}}),")
        instance_code.append(f".{'XOUT':<{max_port_len}} ({xout_pad:<{max_signal_len}}),")
        instance_code.append(f".{'pad_config':<{max_port_len}} ({f'pad_config_{xin_pad}':<{max_signal_len}}),")
        if pad.function0.name:
            instance_code.append(f".{'pad_in':<{max_port_len}} ({f'{pad.function0.name}_i':<{max_signal_len}})")
        else:
            instance_code.append(f".{'pad_in':<{max_port_len}} ()")
        instance_code.append(f");")
        
        return port_inputs, port_outputs, port_inouts, '\n'.join(instance_code)
    
    def generate_io_pad(self, pad: PadInfo) -> Tuple[List[str], List[str], List[str], str]:
        """生成IO类型的PAD代码"""
        port_inputs = []
        port_outputs = []
        port_inouts = []
        instance_code = []
        
        # PAD端口 (inout)
        port_inouts.append(f"    inout       {pad.pad_name},")
        
        # 配置端口
        port_inputs.append(f"    input [3:0] pad_config_{pad.pad_name},")
        
        # 获取有效功能
        active_funcs = self.get_active_functions(pad)
        
        # 判断是否需要mux (多于一个有效功能)
        need_mux = len(active_funcs) > 1
        
        if need_mux:
            # 添加sel端口
            port_inputs.append(f"    input [3:0] pad_sel_{pad.pad_name},")
        
        # 收集输入输出信号
        input_signals = []  # (func_type, func_info, pad_sel)
        output_signals = [] # (func_type, func_info, pad_sel)
        
        for func_type, func_info, pad_sel in active_funcs:
            if self.has_input(func_info.io_type):
                input_signals.append((func_type, func_info, pad_sel))
                port_outputs.append(f"    output      {func_info.name}_i,")
            
            if self.has_output(func_info.io_type):
                output_signals.append((func_type, func_info, pad_sel))
                port_inputs.append(f"    input       {func_info.name}_o,")
                port_inputs.append(f"    input       {func_info.name}_oen,")
        
        # 生成实例化代码
        instance_code.append(self.generate_pad_comment(pad))
        
        # Wire声明
        instance_code.append(f"wire pad_in_{pad.pad_name};")
        instance_code.append(f"wire pad_oen_{pad.pad_name};")
        instance_code.append(f"wire pad_out_{pad.pad_name};")
        instance_code.append("")
        
        # 生成输入MUX (pad_in -> xxx_i)
        # pad_in_xxx是从PAD读取的数据
        if input_signals:
            for func_type, func_info, pad_sel in input_signals:
                if need_mux:
                    instance_code.append(f"assign {func_info.name}_i = pad_sel_{pad.pad_name}=={pad_sel} ? pad_in_{pad.pad_name} : 1'b1;")
                else:
                    instance_code.append(f"assign {func_info.name}_i = pad_in_{pad.pad_name};")
            instance_code.append("")
        
        # 生成输出MUX (xxx_oen -> pad_oen)
        if output_signals:
            if need_mux and len(output_signals) > 1:
                # 多个输出信号，需要MUX，按优先级从高到低
                oen_lines = []
                for func_type, func_info, pad_sel in output_signals:
                    oen_lines.append(f"pad_sel_{pad.pad_name}=={pad_sel} ? {func_info.name}_oen")
                oen_expr = " :\n\t\t\t\t\t\t".join(oen_lines) + " :\n\t\t\t\t\t\t1'b1;"
                instance_code.append(f"assign pad_oen_{pad.pad_name} = {oen_expr}")
            elif len(output_signals) == 1:
                func_info = output_signals[0][1]
                instance_code.append(f"assign pad_oen_{pad.pad_name} = {func_info.name}_oen;")
            else:
                instance_code.append(f"assign pad_oen_{pad.pad_name} = 1'b1; //always disable output")
        else:
            instance_code.append(f"assign pad_oen_{pad.pad_name} = 1'b1; //always disable output")
        
        # 生成输出MUX (xxx_o -> pad_out)
        # pad_out_xxx是写入PAD的数据
        if output_signals:
            if need_mux and len(output_signals) > 1:
                out_lines = []
                for func_type, func_info, pad_sel in output_signals:
                    out_lines.append(f"pad_sel_{pad.pad_name}=={pad_sel} ? {func_info.name}_o")
                out_expr = " :\n\t\t\t\t\t\t".join(out_lines) + " :\n\t\t\t\t\t\t1'b1;"
                instance_code.append(f"assign pad_out_{pad.pad_name} = {out_expr}")
            elif len(output_signals) == 1:
                func_info = output_signals[0][1]
                instance_code.append(f"assign pad_out_{pad.pad_name} = {func_info.name}_o;")
            else:
                instance_code.append(f"assign pad_out_{pad.pad_name} = 1'b0;")
        else:
            instance_code.append(f"assign pad_out_{pad.pad_name} = 1'b0;")
        
        instance_code.append("")
        
        # xs_io 实例化 - 计算对齐宽度
        port_names = ['PAD', 'pad_config', 'pad_in', 'pad_oen', 'pad_out']
        signal_names = [
            pad.pad_name,
            f"pad_config_{pad.pad_name}",
            f"pad_in_{pad.pad_name}",
            f"pad_oen_{pad.pad_name}",
            f"pad_out_{pad.pad_name}"
        ]
        max_port_len = max(len(p) for p in port_names)
        max_signal_len = max(len(s) for s in signal_names)
        
        instance_code.append(f"xs_io #(")
        instance_code.append(f".PHY_DIR({self.get_phy_dir(pad.direction)})")
        instance_code.append(f")u_{pad.pad_name}(")
        instance_code.append(f".{'PAD':<{max_port_len}} ({pad.pad_name:<{max_signal_len}}),")
        instance_code.append(f".{'pad_config':<{max_port_len}} ({f'pad_config_{pad.pad_name}':<{max_signal_len}}),")
        instance_code.append(f".{'pad_in':<{max_port_len}} ({f'pad_in_{pad.pad_name}':<{max_signal_len}}),")
        instance_code.append(f".{'pad_oen':<{max_port_len}} ({f'pad_oen_{pad.pad_name}':<{max_signal_len}}),")
        instance_code.append(f".{'pad_out':<{max_port_len}} ({f'pad_out_{pad.pad_name}':<{max_signal_len}})")
        instance_code.append(f");")
        
        return port_inputs, port_outputs, port_inouts, '\n'.join(instance_code)
    
    def generate_verilog(self):
        """生成完整的Verilog文件"""
        all_inputs = []
        all_outputs = []
        all_inouts = []
        all_instances = []
        
        # PAD定义
        pad_def_inputs = []
        pad_def_outputs = []
        pad_def_inouts = []
        
        # IO配置
        io_config_inputs = []
        
        # IO选择
        io_sel_inputs = []
        
        # 按Function分类的信号
        func0_signals = []  # function 0
        func1_signals = []  # function 1
        func2_signals = []  # function 2
        func3_signals = []  # function 3
        test_signals = []   # test mode
        scan_signals = []   # scan mode
        
        # 用于检测重复端口信号的集合
        declared_signals = set()
        
        def add_signal_if_not_duplicate(signal_list: List[str], line: str, pad_name: str):
            """添加信号到列表，如果信号已存在则报警告并跳过"""
            # 提取信号名称
            parts = line.strip().split()
            if len(parts) >= 2:
                signal_name = parts[-1].rstrip(',')
                if signal_name in declared_signals:
                    print(f"Warning: 信号 {signal_name} 在PAD {pad_name} 中重复定义，已跳过")
                    return False
                declared_signals.add(signal_name)
            signal_list.append(line)
            return True
        
        for pad in self.pads:
            if pad.pad_type == 'CRYSTAL':
                inputs, outputs, inouts, code = self.generate_crystal_io(pad)
                # Crystal的PAD定义
                for line in inputs:
                    if 'pad_config' in line:
                        io_config_inputs.append(line)
                    else:
                        pad_def_inputs.append(line)
                for line in outputs:
                    if '_i,' in line or '_i' in line:
                        # CRYSTAL的function0信号
                        add_signal_if_not_duplicate(func0_signals, line, pad.pad_name)
                    else:
                        pad_def_outputs.append(line)
                all_instances.append(code)
            elif pad.pad_type == 'IO':
                inputs, outputs, inouts, code = self.generate_io_pad(pad)
                # 分类端口
                for line in inputs:
                    if 'pad_config' in line:
                        io_config_inputs.append(line)
                    elif 'pad_sel' in line:
                        io_sel_inputs.append(line)
                    else:
                        # 按function分类，并检测重复
                        self._classify_signal_by_function_with_check(pad, line, 
                            func0_signals, func1_signals, func2_signals, 
                            func3_signals, test_signals, scan_signals,
                            declared_signals)
                for line in outputs:
                    self._classify_signal_by_function_with_check(pad, line,
                        func0_signals, func1_signals, func2_signals,
                        func3_signals, test_signals, scan_signals,
                        declared_signals)
                for line in inouts:
                    pad_def_inouts.append(line)
                all_instances.append(code)
        
        # 组合端口列表
        all_port_lines = []
        all_port_lines.append("    //PAD definition")
        all_port_lines.extend(pad_def_inputs)
        all_port_lines.extend(pad_def_outputs)
        all_port_lines.extend(pad_def_inouts)
        all_port_lines.append("    //IO configuration")
        all_port_lines.extend(io_config_inputs)
        all_port_lines.append("    //IO selection")
        all_port_lines.extend(io_sel_inputs)
        if func0_signals:
            all_port_lines.append("    //function 0")
            all_port_lines.extend(func0_signals)
        if func1_signals:
            all_port_lines.append("    //function 1")
            all_port_lines.extend(func1_signals)
        if func2_signals:
            all_port_lines.append("    //function 2")
            all_port_lines.extend(func2_signals)
        if func3_signals:
            all_port_lines.append("    //function 3")
            all_port_lines.extend(func3_signals)
        if test_signals:
            all_port_lines.append("    //test mode")
            all_port_lines.extend(test_signals)
        if scan_signals:
            all_port_lines.append("    //scan mode")
            all_port_lines.extend(scan_signals)
        
        # 移除最后一个逗号
        port_str = '\n'.join(all_port_lines)
        if port_str.rstrip().endswith(','):
            port_str = port_str.rstrip()[:-1]
        
        # 生成文件头
        header = f"""//==============================================================================
// File name    : {self.module_name}.v
// Description  : IO MUX module
// Generator    : autoio.py
// Author       : czz
// Generated on : {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
//==============================================================================
// pad_sel[3:0] 4'b0000 :function 0
// pad_sel[3:0] 4'b0001 :function 1
// pad_sel[3:0] 4'b0010 :function 2
// pad_sel[3:0] 4'b0011 :function 3
// pad_sel[3:0] 4'b0100 :scan mode
// pad_sel[3:0] 4'b1000 :test mode
// pad_sel[3:0] others  :reserved
//==============================================================================

"""
        
        # 组合完整Verilog
        verilog_code = header
        verilog_code += f"module {self.module_name}(\n"
        verilog_code += port_str + "\n"
        verilog_code += ");\n\n"
        
        # 添加localparam定义
        verilog_code += "//------------------------------------------------------------------------------\n"
        verilog_code += "// pad_sel localparam definition\n"
        verilog_code += "//------------------------------------------------------------------------------\n"
        verilog_code += f"localparam SEL_FUNC0 = {self.PAD_SEL_VALUE['function0']};  // function 0\n"
        verilog_code += f"localparam SEL_FUNC1 = {self.PAD_SEL_VALUE['function1']};  // function 1\n"
        verilog_code += f"localparam SEL_FUNC2 = {self.PAD_SEL_VALUE['function2']};  // function 2\n"
        verilog_code += f"localparam SEL_FUNC3 = {self.PAD_SEL_VALUE['function3']};  // function 3\n"
        verilog_code += f"localparam SEL_SCAN  = {self.PAD_SEL_VALUE['scan_mode']};  // scan mode\n"
        verilog_code += f"localparam SEL_TEST  = {self.PAD_SEL_VALUE['test_mode']};  // test mode\n"
        verilog_code += "\n"
        
        for instance in all_instances:
            verilog_code += "\n" + instance + "\n"
        
        verilog_code += "\nendmodule\n"
        
        return verilog_code
    
    def run(self):
        """运行生成器"""
        print(f"解析表格: {self.input_file}")
        self.parse_excel()
        
        print(f"找到 {len(self.pads)} 个需要生成的PAD")
        for pad in self.pads:
            print(f"  - {pad.pad_name} ({pad.pad_type})")
        
        print(f"生成Verilog代码...")
        verilog_code = self.generate_verilog()
        
        # 确保输出目录存在
        output_dir = os.path.dirname(self.output_path)
        if output_dir and not os.path.exists(output_dir):
            os.makedirs(output_dir)
        
        # 写入文件
        with open(self.output_path, 'w', encoding='utf-8') as f:
            f.write(verilog_code)
        
        print(f"Verilog代码已生成: {self.output_path}")


def main():
    parser = argparse.ArgumentParser(description='Auto IO Verilog Generator - 根据IO MUX表格自动生成Verilog代码')
    parser.add_argument('-i', '--input', required=True, help='输入表格路径+表格名称 (xlsx格式)')
    parser.add_argument('-o', '--output_path', required=True, help='输出Verilog路径+模块名称 (如: output/io_top.v)')
    
    args = parser.parse_args()
    
    # 检查输入文件是否存在
    if not os.path.exists(args.input):
        print(f"Error: 输入文件不存在: {args.input}")
        sys.exit(1)
    
    generator = AutoIOGenerator(args.input, args.output_path)
    generator.run()


if __name__ == '__main__':
    main()
