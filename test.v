//==============================================================================
// File name    : test.v
// Description  : IO MUX module
// Generator    : autoio.py
// Author       : czz
// Generated on : 2026-03-30 14:17:16
//==============================================================================
// pad_sel[3:0] 4'b0000 :function 0
// pad_sel[3:0] 4'b0001 :function 1
// pad_sel[3:0] 4'b0010 :function 2
// pad_sel[3:0] 4'b0011 :function 3
// pad_sel[3:0] 4'b0100 :scan mode
// pad_sel[3:0] 4'b1000 :test mode
// pad_sel[3:0] others  :reserved
//==============================================================================

module test(
    //PAD definition
    input       XI,
    output      XO,
    inout       TEST_MODE,
    inout       MEM_REPAIR_DIS,
    inout       JTAG_TCK,
    inout       JTAG_NTRST,
    inout       JTAG_TMS,
    inout       JTAG_TDI,
    inout       JTAG_TDO,
    inout       REF_CLK,
    inout       POR_N,
    inout       ENET_REF_CLK,
    inout       PCIE_PERSTN,
    inout       FLASH_CFG,
    inout       BOOT_MODE,
    inout       CFG0,
    inout       CFG1,
    inout       CFG2,
    inout       CFG3,
    inout       CFG4,
    inout       CFG5,
    inout       SCLOCK0,
    inout       SLOAD0,
    inout       SDATAIN0,
    inout       SDATAOUT0,
    inout       SCLOCK1,
    inout       SLOAD1,
    inout       SDATAIN1,
    inout       SDATAOUT1,
    inout       SCLOCK2,
    inout       SLOAD2,
    inout       SDATAIN2,
    inout       SDATAOUT2,
    inout       SCLOCK3,
    inout       SLOAD3,
    inout       SDATAIN3,
    inout       SDATAOUT3,
    inout       SMCLK,
    inout       SMDATA,
    inout       SCL0,
    inout       SDA0,
    inout       SCL2,
    inout       SDA2,
    inout       SCL3,
    inout       SDA3,
    inout       RGMII_MDC,
    inout       RGMII_MDIO,
    //IO configuration
    input [3:0] pad_config_TEST_MODE,
    input [3:0] pad_config_MEM_REPAIR_DIS,
    input [3:0] pad_config_JTAG_TCK,
    input [3:0] pad_config_JTAG_NTRST,
    input [3:0] pad_config_JTAG_TMS,
    input [3:0] pad_config_JTAG_TDI,
    input [3:0] pad_config_JTAG_TDO,
    input [3:0] pad_config_REF_CLK,
    input [3:0] pad_config_POR_N,
    input [3:0] pad_config_ENET_REF_CLK,
    input [3:0] pad_config_PCIE_PERSTN,
    input [3:0] pad_config_FLASH_CFG,
    input [3:0] pad_config_BOOT_MODE,
    input [3:0] pad_config_CFG0,
    input [3:0] pad_config_CFG1,
    input [3:0] pad_config_CFG2,
    input [3:0] pad_config_CFG3,
    input [3:0] pad_config_CFG4,
    input [3:0] pad_config_CFG5,
    input [3:0] pad_config_SCLOCK0,
    input [3:0] pad_config_SLOAD0,
    input [3:0] pad_config_SDATAIN0,
    input [3:0] pad_config_SDATAOUT0,
    input [3:0] pad_config_SCLOCK1,
    input [3:0] pad_config_SLOAD1,
    input [3:0] pad_config_SDATAIN1,
    input [3:0] pad_config_SDATAOUT1,
    input [3:0] pad_config_SCLOCK2,
    input [3:0] pad_config_SLOAD2,
    input [3:0] pad_config_SDATAIN2,
    input [3:0] pad_config_SDATAOUT2,
    input [3:0] pad_config_SCLOCK3,
    input [3:0] pad_config_SLOAD3,
    input [3:0] pad_config_SDATAIN3,
    input [3:0] pad_config_SDATAOUT3,
    input [3:0] pad_config_SMCLK,
    input [3:0] pad_config_SMDATA,
    input [3:0] pad_config_SCL0,
    input [3:0] pad_config_SDA0,
    input [3:0] pad_config_SCL2,
    input [3:0] pad_config_SDA2,
    input [3:0] pad_config_SCL3,
    input [3:0] pad_config_SDA3,
    input [3:0] pad_config_RGMII_MDC,
    input [3:0] pad_config_RGMII_MDIO,
    input [3:0] pad_config_XI,
    //IO selection
    input [3:0] pad_sel_JTAG_TCK,
    input [3:0] pad_sel_JTAG_NTRST,
    input [3:0] pad_sel_JTAG_TMS,
    input [3:0] pad_sel_JTAG_TDI,
    input [3:0] pad_sel_JTAG_TDO,
    input [3:0] pad_sel_ENET_REF_CLK,
    input [3:0] pad_sel_PCIE_PERSTN,
    input [3:0] pad_sel_FLASH_CFG,
    input [3:0] pad_sel_BOOT_MODE,
    input [3:0] pad_sel_CFG0,
    input [3:0] pad_sel_CFG1,
    input [3:0] pad_sel_CFG2,
    input [3:0] pad_sel_CFG3,
    input [3:0] pad_sel_CFG4,
    input [3:0] pad_sel_CFG5,
    input [3:0] pad_sel_SCLOCK0,
    input [3:0] pad_sel_SLOAD0,
    input [3:0] pad_sel_SDATAIN0,
    input [3:0] pad_sel_SDATAOUT0,
    input [3:0] pad_sel_SCLOCK1,
    input [3:0] pad_sel_SLOAD1,
    input [3:0] pad_sel_SDATAIN1,
    input [3:0] pad_sel_SDATAOUT1,
    input [3:0] pad_sel_SCLOCK2,
    input [3:0] pad_sel_SLOAD2,
    input [3:0] pad_sel_SDATAIN2,
    input [3:0] pad_sel_SDATAOUT2,
    input [3:0] pad_sel_SCLOCK3,
    input [3:0] pad_sel_SLOAD3,
    input [3:0] pad_sel_SDATAIN3,
    input [3:0] pad_sel_SDATAOUT3,
    input [3:0] pad_sel_SMCLK,
    input [3:0] pad_sel_SMDATA,
    input [3:0] pad_sel_SCL0,
    input [3:0] pad_sel_SDA0,
    input [3:0] pad_sel_SCL3,
    input [3:0] pad_sel_SDA3,
    input [3:0] pad_sel_RGMII_MDC,
    input [3:0] pad_sel_RGMII_MDIO,
    //function 0
    output      test_mode_i,
    output      mem_repair_dis_i,
    output      jtag_tck_i,
    output      jtag_ntrst_i,
    input       jtag_tms_o,
    input       jtag_tms_oen,
    output      jtag_tms_i,
    output      jtag_tdi_i,
    input       jtag_tdo_o,
    input       jtag_tdo_oen,
    output      ref_clk_i,
    output      por_n_i,
    output      enet_ref_clk_i,
    output      pcie_perstn_i,
    output      flash_cfg_i,
    output      boot_mode_i,
    output      cfg0_i,
    output      cfg1_i,
    output      cfg2_i,
    output      cfg3_i,
    output      cfg4_i,
    output      cfg5_i,
    input       sclock0_o,
    input       sclock0_oen,
    input       sload0_o,
    input       sload0_oen,
    output      sdatain0_i,
    input       sdataout0_o,
    input       sdataout0_oen,
    input       sclock1_o,
    input       sclock1_oen,
    input       sload1_o,
    input       sload1_oen,
    output      sdatain1_i,
    input       sdataout1_o,
    input       sdataout1_oen,
    input       sclock2_o,
    input       sclock2_oen,
    input       sload2_o,
    input       sload2_oen,
    output      sdatain2_i,
    input       sdataout2_o,
    input       sdataout2_oen,
    input       sclock3_o,
    input       sclock3_oen,
    input       sload3_o,
    input       sload3_oen,
    output      sdatain3_i,
    input       sdataout3_o,
    input       sdataout3_oen,
    input       smclk_o,
    input       smclk_oen,
    output      smclk_i,
    input       smdata_o,
    input       smdata_oen,
    output      smdata_i,
    input       scl0_o,
    input       scl0_oen,
    output      scl0_i,
    input       sda0_o,
    input       sda0_oen,
    output      sda0_i,
    input       scl2_o,
    input       scl2_oen,
    output      scl2_i,
    input       sda2_o,
    input       sda2_oen,
    output      sda2_i,
    input       scl3_o,
    input       scl3_oen,
    output      scl3_i,
    input       sda3_o,
    input       sda3_oen,
    output      sda3_i,
    input       rgmii_mdc_o,
    input       rgmii_mdc_oen,
    input       rgmii_mdio_o,
    input       rgmii_mdio_oen,
    output      rgmii_mdio_i,
    output      clk_25m_i,
    //function 1
    input       mon_clk_o,
    input       mon_clk_oen,
    input       gpio0_o,
    input       gpio0_oen,
    output      gpio0_i,
    input       gpio1_o,
    input       gpio1_oen,
    output      gpio1_i,
    input       gpio2_o,
    input       gpio2_oen,
    output      gpio2_i,
    input       gpio3_o,
    input       gpio3_oen,
    output      gpio3_i,
    input       gpio4_o,
    input       gpio4_oen,
    output      gpio4_i,
    input       gpio5_o,
    input       gpio5_oen,
    output      gpio5_i,
    input       gpio6_o,
    input       gpio6_oen,
    output      gpio6_i,
    input       gpio7_o,
    input       gpio7_oen,
    output      gpio7_i,
    input       gpio8_o,
    input       gpio8_oen,
    output      gpio8_i,
    input       gpio9_o,
    input       gpio9_oen,
    output      gpio9_i,
    input       gpio10_o,
    input       gpio10_oen,
    output      gpio10_i,
    input       gpio11_o,
    input       gpio11_oen,
    output      gpio11_i,
    //function 2
    input       cpu_mon_clk_o,
    input       cpu_mon_clk_oen,
    input       sas8_perstn_o,
    input       sas8_perstn_oen,
    input       sas9_perstn_o,
    input       sas9_perstn_oen,
    //test mode
    output      ijtag_tck_i,
    output      ijtag_ntrst_i,
    output      ijtag_tms_i,
    output      ijtag_tdi_i,
    input       ijtag_tdo_o,
    input       ijtag_tdo_oen,
    output      test_clk_i,
    output      test_rstn_i,
    //scan mode
    output      scan_en_i,
    output      edt_update_i,
    output      edt_ch_in0_i,
    output      edt_ch_in1_i,
    output      edt_ch_in2_i,
    output      edt_ch_in3_i,
    output      edt_ch_in4_i,
    output      edt_ch_in5_i,
    output      edt_ch_in6_i,
    output      edt_ch_in7_i,
    output      edt_ch_in8_i,
    output      edt_ch_in9_i,
    output      edt_ch_in10_i,
    output      edt_ch_in11_i,
    output      edt_ch_in12_i,
    output      edt_ch_in13_i,
    output      edt_ch_in14_i,
    output      edt_ch_in15_i,
    output      edt_ch_in16_i,
    output      edt_ch_in17_i,
    output      edt_ch_in18_i,
    output      edt_ch_in19_i,
    output      edt_ch_in20_i,
    output      edt_ch_in21_i,
    input       edt_ch_out0_o,
    input       edt_ch_out0_oen,
    input       edt_ch_out1_o,
    input       edt_ch_out1_oen,
    input       edt_ch_out2_o,
    input       edt_ch_out2_oen,
    input       edt_ch_out3_o,
    input       edt_ch_out3_oen,
    input       edt_ch_out4_o,
    input       edt_ch_out4_oen,
    input       edt_ch_out5_o,
    input       edt_ch_out5_oen
);

//------------------------------------------------------------------------------
// pad_sel localparam definition
//------------------------------------------------------------------------------
localparam SEL_FUNC0 = 4'b0000;  // function 0
localparam SEL_FUNC1 = 4'b0001;  // function 1
localparam SEL_FUNC2 = 4'b0010;  // function 2
localparam SEL_FUNC3 = 4'b0011;  // function 3
localparam SEL_SCAN  = 4'b0100;  // scan mode
localparam SEL_TEST  = 4'b1000;  // test mode


//----------------------------------------------------------------
// PAD_NAME         :TEST_MODE
// TYPE             :IO
// CELL_NAME        :PRDWUW1216DGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :test_mode       IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_TEST_MODE;
wire pad_oen_TEST_MODE;
wire pad_out_TEST_MODE;

assign test_mode_i = pad_in_TEST_MODE;

assign pad_oen_TEST_MODE = 1'b1; //always disable output
assign pad_out_TEST_MODE = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 0 )
)u_TEST_MODE(
.PAD        (TEST_MODE           ),
.pad_config (pad_config_TEST_MODE),
.pad_in     (pad_in_TEST_MODE    ),
.pad_oen    (pad_oen_TEST_MODE   ),
.pad_out    (pad_out_TEST_MODE   )
);

//----------------------------------------------------------------
// PAD_NAME         :MEM_REPAIR_DIS
// TYPE             :IO
// CELL_NAME        :PRDWUW1216DGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :mem_repair_dis  IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_MEM_REPAIR_DIS;
wire pad_oen_MEM_REPAIR_DIS;
wire pad_out_MEM_REPAIR_DIS;

assign mem_repair_dis_i = pad_in_MEM_REPAIR_DIS;

assign pad_oen_MEM_REPAIR_DIS = 1'b1; //always disable output
assign pad_out_MEM_REPAIR_DIS = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 0 )
)u_MEM_REPAIR_DIS(
.PAD        (MEM_REPAIR_DIS           ),
.pad_config (pad_config_MEM_REPAIR_DIS),
.pad_in     (pad_in_MEM_REPAIR_DIS    ),
.pad_oen    (pad_oen_MEM_REPAIR_DIS   ),
.pad_out    (pad_out_MEM_REPAIR_DIS   )
);

//----------------------------------------------------------------
// PAD_NAME         :JTAG_TCK
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :jtag_tck        IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :ijtag_tck       IO:I
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_JTAG_TCK;
wire pad_oen_JTAG_TCK;
wire pad_out_JTAG_TCK;

assign ijtag_tck_i = pad_sel_JTAG_TCK==SEL_TEST ? pad_in_JTAG_TCK : 1'b1;
assign jtag_tck_i = pad_sel_JTAG_TCK==SEL_FUNC0 ? pad_in_JTAG_TCK : 1'b1;

assign pad_oen_JTAG_TCK = 1'b1; //always disable output
assign pad_out_JTAG_TCK = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_JTAG_TCK(
.PAD        (JTAG_TCK           ),
.pad_config (pad_config_JTAG_TCK),
.pad_in     (pad_in_JTAG_TCK    ),
.pad_oen    (pad_oen_JTAG_TCK   ),
.pad_out    (pad_out_JTAG_TCK   )
);

//----------------------------------------------------------------
// PAD_NAME         :JTAG_NTRST
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :jtag_ntrst      IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :ijtag_ntrst     IO:I
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_JTAG_NTRST;
wire pad_oen_JTAG_NTRST;
wire pad_out_JTAG_NTRST;

assign ijtag_ntrst_i = pad_sel_JTAG_NTRST==SEL_TEST ? pad_in_JTAG_NTRST : 1'b1;
assign jtag_ntrst_i = pad_sel_JTAG_NTRST==SEL_FUNC0 ? pad_in_JTAG_NTRST : 1'b1;

assign pad_oen_JTAG_NTRST = 1'b1; //always disable output
assign pad_out_JTAG_NTRST = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_JTAG_NTRST(
.PAD        (JTAG_NTRST           ),
.pad_config (pad_config_JTAG_NTRST),
.pad_in     (pad_in_JTAG_NTRST    ),
.pad_oen    (pad_oen_JTAG_NTRST   ),
.pad_out    (pad_out_JTAG_NTRST   )
);

//----------------------------------------------------------------
// PAD_NAME         :JTAG_TMS
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :jtag_tms        IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :ijtag_tms       IO:I
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_JTAG_TMS;
wire pad_oen_JTAG_TMS;
wire pad_out_JTAG_TMS;

assign ijtag_tms_i = pad_sel_JTAG_TMS==SEL_TEST ? pad_in_JTAG_TMS : 1'b1;
assign jtag_tms_i = pad_sel_JTAG_TMS==SEL_FUNC0 ? pad_in_JTAG_TMS : 1'b1;

assign pad_oen_JTAG_TMS = jtag_tms_oen;
assign pad_out_JTAG_TMS = jtag_tms_o;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_JTAG_TMS(
.PAD        (JTAG_TMS           ),
.pad_config (pad_config_JTAG_TMS),
.pad_in     (pad_in_JTAG_TMS    ),
.pad_oen    (pad_oen_JTAG_TMS   ),
.pad_out    (pad_out_JTAG_TMS   )
);

//----------------------------------------------------------------
// PAD_NAME         :JTAG_TDI
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :jtag_tdi        IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :ijtag_tdi       IO:I
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_JTAG_TDI;
wire pad_oen_JTAG_TDI;
wire pad_out_JTAG_TDI;

assign ijtag_tdi_i = pad_sel_JTAG_TDI==SEL_TEST ? pad_in_JTAG_TDI : 1'b1;
assign jtag_tdi_i = pad_sel_JTAG_TDI==SEL_FUNC0 ? pad_in_JTAG_TDI : 1'b1;

assign pad_oen_JTAG_TDI = 1'b1; //always disable output
assign pad_out_JTAG_TDI = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_JTAG_TDI(
.PAD        (JTAG_TDI           ),
.pad_config (pad_config_JTAG_TDI),
.pad_in     (pad_in_JTAG_TDI    ),
.pad_oen    (pad_oen_JTAG_TDI   ),
.pad_out    (pad_out_JTAG_TDI   )
);

//----------------------------------------------------------------
// PAD_NAME         :JTAG_TDO
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :jtag_tdo        IO:O
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :ijtag_tdo       IO:O
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_JTAG_TDO;
wire pad_oen_JTAG_TDO;
wire pad_out_JTAG_TDO;

assign pad_oen_JTAG_TDO = pad_sel_JTAG_TDO==SEL_TEST ? ijtag_tdo_oen :
						pad_sel_JTAG_TDO==SEL_FUNC0 ? jtag_tdo_oen :
						1'b1;
assign pad_out_JTAG_TDO = pad_sel_JTAG_TDO==SEL_TEST ? ijtag_tdo_o :
						pad_sel_JTAG_TDO==SEL_FUNC0 ? jtag_tdo_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_JTAG_TDO(
.PAD        (JTAG_TDO           ),
.pad_config (pad_config_JTAG_TDO),
.pad_in     (pad_in_JTAG_TDO    ),
.pad_oen    (pad_oen_JTAG_TDO   ),
.pad_out    (pad_out_JTAG_TDO   )
);

//----------------------------------------------------------------
// PAD_NAME         :REF_CLK
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :ref_clk         IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_REF_CLK;
wire pad_oen_REF_CLK;
wire pad_out_REF_CLK;

assign ref_clk_i = pad_in_REF_CLK;

assign pad_oen_REF_CLK = 1'b1; //always disable output
assign pad_out_REF_CLK = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_REF_CLK(
.PAD        (REF_CLK           ),
.pad_config (pad_config_REF_CLK),
.pad_in     (pad_in_REF_CLK    ),
.pad_oen    (pad_oen_REF_CLK   ),
.pad_out    (pad_out_REF_CLK   )
);

//----------------------------------------------------------------
// PAD_NAME         :POR_N
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :por_n           IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_POR_N;
wire pad_oen_POR_N;
wire pad_out_POR_N;

assign por_n_i = pad_in_POR_N;

assign pad_oen_POR_N = 1'b1; //always disable output
assign pad_out_POR_N = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_POR_N(
.PAD        (POR_N           ),
.pad_config (pad_config_POR_N),
.pad_in     (pad_in_POR_N    ),
.pad_oen    (pad_oen_POR_N   ),
.pad_out    (pad_out_POR_N   )
);

//----------------------------------------------------------------
// PAD_NAME         :ENET_REF_CLK
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :enet_ref_clk    IO:I
// Function1        :mon_clk         IO:O
// Function2        :cpu_mon_clk     IO:O
// Function3        :None            IO:None
// Test_mode        :test_clk        IO:I
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_ENET_REF_CLK;
wire pad_oen_ENET_REF_CLK;
wire pad_out_ENET_REF_CLK;

assign test_clk_i = pad_sel_ENET_REF_CLK==SEL_TEST ? pad_in_ENET_REF_CLK : 1'b1;
assign enet_ref_clk_i = pad_sel_ENET_REF_CLK==SEL_FUNC0 ? pad_in_ENET_REF_CLK : 1'b1;

assign pad_oen_ENET_REF_CLK = pad_sel_ENET_REF_CLK==SEL_FUNC2 ? cpu_mon_clk_oen :
						pad_sel_ENET_REF_CLK==SEL_FUNC1 ? mon_clk_oen :
						1'b1;
assign pad_out_ENET_REF_CLK = pad_sel_ENET_REF_CLK==SEL_FUNC2 ? cpu_mon_clk_o :
						pad_sel_ENET_REF_CLK==SEL_FUNC1 ? mon_clk_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_ENET_REF_CLK(
.PAD        (ENET_REF_CLK           ),
.pad_config (pad_config_ENET_REF_CLK),
.pad_in     (pad_in_ENET_REF_CLK    ),
.pad_oen    (pad_oen_ENET_REF_CLK   ),
.pad_out    (pad_out_ENET_REF_CLK   )
);

//----------------------------------------------------------------
// PAD_NAME         :PCIE_PERSTN
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :pcie_perstn     IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :test_rstn       IO:I
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_PCIE_PERSTN;
wire pad_oen_PCIE_PERSTN;
wire pad_out_PCIE_PERSTN;

assign test_rstn_i = pad_sel_PCIE_PERSTN==SEL_TEST ? pad_in_PCIE_PERSTN : 1'b1;
assign pcie_perstn_i = pad_sel_PCIE_PERSTN==SEL_FUNC0 ? pad_in_PCIE_PERSTN : 1'b1;

assign pad_oen_PCIE_PERSTN = 1'b1; //always disable output
assign pad_out_PCIE_PERSTN = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_PCIE_PERSTN(
.PAD        (PCIE_PERSTN           ),
.pad_config (pad_config_PCIE_PERSTN),
.pad_in     (pad_in_PCIE_PERSTN    ),
.pad_oen    (pad_oen_PCIE_PERSTN   ),
.pad_out    (pad_out_PCIE_PERSTN   )
);

//----------------------------------------------------------------
// PAD_NAME         :FLASH_CFG
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :flash_cfg       IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :scan_en         IO:I
//----------------------------------------------------------------
wire pad_in_FLASH_CFG;
wire pad_oen_FLASH_CFG;
wire pad_out_FLASH_CFG;

assign scan_en_i = pad_sel_FLASH_CFG==SEL_SCAN ? pad_in_FLASH_CFG : 1'b1;
assign flash_cfg_i = pad_sel_FLASH_CFG==SEL_FUNC0 ? pad_in_FLASH_CFG : 1'b1;

assign pad_oen_FLASH_CFG = 1'b1; //always disable output
assign pad_out_FLASH_CFG = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_FLASH_CFG(
.PAD        (FLASH_CFG           ),
.pad_config (pad_config_FLASH_CFG),
.pad_in     (pad_in_FLASH_CFG    ),
.pad_oen    (pad_oen_FLASH_CFG   ),
.pad_out    (pad_out_FLASH_CFG   )
);

//----------------------------------------------------------------
// PAD_NAME         :BOOT_MODE
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :boot_mode       IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_update      IO:I
//----------------------------------------------------------------
wire pad_in_BOOT_MODE;
wire pad_oen_BOOT_MODE;
wire pad_out_BOOT_MODE;

assign edt_update_i = pad_sel_BOOT_MODE==SEL_SCAN ? pad_in_BOOT_MODE : 1'b1;
assign boot_mode_i = pad_sel_BOOT_MODE==SEL_FUNC0 ? pad_in_BOOT_MODE : 1'b1;

assign pad_oen_BOOT_MODE = 1'b1; //always disable output
assign pad_out_BOOT_MODE = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_BOOT_MODE(
.PAD        (BOOT_MODE           ),
.pad_config (pad_config_BOOT_MODE),
.pad_in     (pad_in_BOOT_MODE    ),
.pad_oen    (pad_oen_BOOT_MODE   ),
.pad_out    (pad_out_BOOT_MODE   )
);

//----------------------------------------------------------------
// PAD_NAME         :CFG0
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :cfg0            IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in0      IO:I
//----------------------------------------------------------------
wire pad_in_CFG0;
wire pad_oen_CFG0;
wire pad_out_CFG0;

assign edt_ch_in0_i = pad_sel_CFG0==SEL_SCAN ? pad_in_CFG0 : 1'b1;
assign cfg0_i = pad_sel_CFG0==SEL_FUNC0 ? pad_in_CFG0 : 1'b1;

assign pad_oen_CFG0 = 1'b1; //always disable output
assign pad_out_CFG0 = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_CFG0(
.PAD        (CFG0           ),
.pad_config (pad_config_CFG0),
.pad_in     (pad_in_CFG0    ),
.pad_oen    (pad_oen_CFG0   ),
.pad_out    (pad_out_CFG0   )
);

//----------------------------------------------------------------
// PAD_NAME         :CFG1
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :cfg1            IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in1      IO:I
//----------------------------------------------------------------
wire pad_in_CFG1;
wire pad_oen_CFG1;
wire pad_out_CFG1;

assign edt_ch_in1_i = pad_sel_CFG1==SEL_SCAN ? pad_in_CFG1 : 1'b1;
assign cfg1_i = pad_sel_CFG1==SEL_FUNC0 ? pad_in_CFG1 : 1'b1;

assign pad_oen_CFG1 = 1'b1; //always disable output
assign pad_out_CFG1 = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_CFG1(
.PAD        (CFG1           ),
.pad_config (pad_config_CFG1),
.pad_in     (pad_in_CFG1    ),
.pad_oen    (pad_oen_CFG1   ),
.pad_out    (pad_out_CFG1   )
);

//----------------------------------------------------------------
// PAD_NAME         :CFG2
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :cfg2            IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in2      IO:I
//----------------------------------------------------------------
wire pad_in_CFG2;
wire pad_oen_CFG2;
wire pad_out_CFG2;

assign edt_ch_in2_i = pad_sel_CFG2==SEL_SCAN ? pad_in_CFG2 : 1'b1;
assign cfg2_i = pad_sel_CFG2==SEL_FUNC0 ? pad_in_CFG2 : 1'b1;

assign pad_oen_CFG2 = 1'b1; //always disable output
assign pad_out_CFG2 = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_CFG2(
.PAD        (CFG2           ),
.pad_config (pad_config_CFG2),
.pad_in     (pad_in_CFG2    ),
.pad_oen    (pad_oen_CFG2   ),
.pad_out    (pad_out_CFG2   )
);

//----------------------------------------------------------------
// PAD_NAME         :CFG3
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_V
// Direction        :NS
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :cfg3            IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in3      IO:I
//----------------------------------------------------------------
wire pad_in_CFG3;
wire pad_oen_CFG3;
wire pad_out_CFG3;

assign edt_ch_in3_i = pad_sel_CFG3==SEL_SCAN ? pad_in_CFG3 : 1'b1;
assign cfg3_i = pad_sel_CFG3==SEL_FUNC0 ? pad_in_CFG3 : 1'b1;

assign pad_oen_CFG3 = 1'b1; //always disable output
assign pad_out_CFG3 = 1'b0;

xs_io #(
.PHY_DIR          ( 1 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_CFG3(
.PAD        (CFG3           ),
.pad_config (pad_config_CFG3),
.pad_in     (pad_in_CFG3    ),
.pad_oen    (pad_oen_CFG3   ),
.pad_out    (pad_out_CFG3   )
);

//----------------------------------------------------------------
// PAD_NAME         :CFG4
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :cfg4            IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in4      IO:I
//----------------------------------------------------------------
wire pad_in_CFG4;
wire pad_oen_CFG4;
wire pad_out_CFG4;

assign edt_ch_in4_i = pad_sel_CFG4==SEL_SCAN ? pad_in_CFG4 : 1'b1;
assign cfg4_i = pad_sel_CFG4==SEL_FUNC0 ? pad_in_CFG4 : 1'b1;

assign pad_oen_CFG4 = 1'b1; //always disable output
assign pad_out_CFG4 = 1'b0;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_CFG4(
.PAD        (CFG4           ),
.pad_config (pad_config_CFG4),
.pad_in     (pad_in_CFG4    ),
.pad_oen    (pad_oen_CFG4   ),
.pad_out    (pad_out_CFG4   )
);

//----------------------------------------------------------------
// PAD_NAME         :CFG5
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :cfg5            IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in5      IO:I
//----------------------------------------------------------------
wire pad_in_CFG5;
wire pad_oen_CFG5;
wire pad_out_CFG5;

assign edt_ch_in5_i = pad_sel_CFG5==SEL_SCAN ? pad_in_CFG5 : 1'b1;
assign cfg5_i = pad_sel_CFG5==SEL_FUNC0 ? pad_in_CFG5 : 1'b1;

assign pad_oen_CFG5 = 1'b1; //always disable output
assign pad_out_CFG5 = 1'b0;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_CFG5(
.PAD        (CFG5           ),
.pad_config (pad_config_CFG5),
.pad_in     (pad_in_CFG5    ),
.pad_oen    (pad_oen_CFG5   ),
.pad_out    (pad_out_CFG5   )
);

//----------------------------------------------------------------
// PAD_NAME         :SCLOCK0
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sclock0         IO:O
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in6      IO:I
//----------------------------------------------------------------
wire pad_in_SCLOCK0;
wire pad_oen_SCLOCK0;
wire pad_out_SCLOCK0;

assign edt_ch_in6_i = pad_sel_SCLOCK0==SEL_SCAN ? pad_in_SCLOCK0 : 1'b1;

assign pad_oen_SCLOCK0 = sclock0_oen;
assign pad_out_SCLOCK0 = sclock0_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SCLOCK0(
.PAD        (SCLOCK0           ),
.pad_config (pad_config_SCLOCK0),
.pad_in     (pad_in_SCLOCK0    ),
.pad_oen    (pad_oen_SCLOCK0   ),
.pad_out    (pad_out_SCLOCK0   )
);

//----------------------------------------------------------------
// PAD_NAME         :SLOAD0
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sload0          IO:O
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in7      IO:I
//----------------------------------------------------------------
wire pad_in_SLOAD0;
wire pad_oen_SLOAD0;
wire pad_out_SLOAD0;

assign edt_ch_in7_i = pad_sel_SLOAD0==SEL_SCAN ? pad_in_SLOAD0 : 1'b1;

assign pad_oen_SLOAD0 = sload0_oen;
assign pad_out_SLOAD0 = sload0_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SLOAD0(
.PAD        (SLOAD0           ),
.pad_config (pad_config_SLOAD0),
.pad_in     (pad_in_SLOAD0    ),
.pad_oen    (pad_oen_SLOAD0   ),
.pad_out    (pad_out_SLOAD0   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAIN0
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sdatain0        IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in8      IO:I
//----------------------------------------------------------------
wire pad_in_SDATAIN0;
wire pad_oen_SDATAIN0;
wire pad_out_SDATAIN0;

assign edt_ch_in8_i = pad_sel_SDATAIN0==SEL_SCAN ? pad_in_SDATAIN0 : 1'b1;
assign sdatain0_i = pad_sel_SDATAIN0==SEL_FUNC0 ? pad_in_SDATAIN0 : 1'b1;

assign pad_oen_SDATAIN0 = 1'b1; //always disable output
assign pad_out_SDATAIN0 = 1'b0;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SDATAIN0(
.PAD        (SDATAIN0           ),
.pad_config (pad_config_SDATAIN0),
.pad_in     (pad_in_SDATAIN0    ),
.pad_oen    (pad_oen_SDATAIN0   ),
.pad_out    (pad_out_SDATAIN0   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAOUT0
// TYPE             :IO
// CELL_NAME        :PRDWUW1216SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sdataout0       IO:O
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in9      IO:I
//----------------------------------------------------------------
wire pad_in_SDATAOUT0;
wire pad_oen_SDATAOUT0;
wire pad_out_SDATAOUT0;

assign edt_ch_in9_i = pad_sel_SDATAOUT0==SEL_SCAN ? pad_in_SDATAOUT0 : 1'b1;

assign pad_oen_SDATAOUT0 = sdataout0_oen;
assign pad_out_SDATAOUT0 = sdataout0_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SDATAOUT0(
.PAD        (SDATAOUT0           ),
.pad_config (pad_config_SDATAOUT0),
.pad_in     (pad_in_SDATAOUT0    ),
.pad_oen    (pad_oen_SDATAOUT0   ),
.pad_out    (pad_out_SDATAOUT0   )
);

//----------------------------------------------------------------
// PAD_NAME         :SCLOCK1
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sclock1         IO:O
// Function1        :gpio0           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in10     IO:I
//----------------------------------------------------------------
wire pad_in_SCLOCK1;
wire pad_oen_SCLOCK1;
wire pad_out_SCLOCK1;

assign edt_ch_in10_i = pad_sel_SCLOCK1==SEL_SCAN ? pad_in_SCLOCK1 : 1'b1;
assign gpio0_i = pad_sel_SCLOCK1==SEL_FUNC1 ? pad_in_SCLOCK1 : 1'b1;

assign pad_oen_SCLOCK1 = pad_sel_SCLOCK1==SEL_FUNC1 ? gpio0_oen :
						pad_sel_SCLOCK1==SEL_FUNC0 ? sclock1_oen :
						1'b1;
assign pad_out_SCLOCK1 = pad_sel_SCLOCK1==SEL_FUNC1 ? gpio0_o :
						pad_sel_SCLOCK1==SEL_FUNC0 ? sclock1_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SCLOCK1(
.PAD        (SCLOCK1           ),
.pad_config (pad_config_SCLOCK1),
.pad_in     (pad_in_SCLOCK1    ),
.pad_oen    (pad_oen_SCLOCK1   ),
.pad_out    (pad_out_SCLOCK1   )
);

//----------------------------------------------------------------
// PAD_NAME         :SLOAD1
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sload1          IO:O
// Function1        :gpio1           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in11     IO:I
//----------------------------------------------------------------
wire pad_in_SLOAD1;
wire pad_oen_SLOAD1;
wire pad_out_SLOAD1;

assign edt_ch_in11_i = pad_sel_SLOAD1==SEL_SCAN ? pad_in_SLOAD1 : 1'b1;
assign gpio1_i = pad_sel_SLOAD1==SEL_FUNC1 ? pad_in_SLOAD1 : 1'b1;

assign pad_oen_SLOAD1 = pad_sel_SLOAD1==SEL_FUNC1 ? gpio1_oen :
						pad_sel_SLOAD1==SEL_FUNC0 ? sload1_oen :
						1'b1;
assign pad_out_SLOAD1 = pad_sel_SLOAD1==SEL_FUNC1 ? gpio1_o :
						pad_sel_SLOAD1==SEL_FUNC0 ? sload1_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SLOAD1(
.PAD        (SLOAD1           ),
.pad_config (pad_config_SLOAD1),
.pad_in     (pad_in_SLOAD1    ),
.pad_oen    (pad_oen_SLOAD1   ),
.pad_out    (pad_out_SLOAD1   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAIN1
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sdatain1        IO:I
// Function1        :gpio2           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in12     IO:I
//----------------------------------------------------------------
wire pad_in_SDATAIN1;
wire pad_oen_SDATAIN1;
wire pad_out_SDATAIN1;

assign edt_ch_in12_i = pad_sel_SDATAIN1==SEL_SCAN ? pad_in_SDATAIN1 : 1'b1;
assign gpio2_i = pad_sel_SDATAIN1==SEL_FUNC1 ? pad_in_SDATAIN1 : 1'b1;
assign sdatain1_i = pad_sel_SDATAIN1==SEL_FUNC0 ? pad_in_SDATAIN1 : 1'b1;

assign pad_oen_SDATAIN1 = gpio2_oen;
assign pad_out_SDATAIN1 = gpio2_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SDATAIN1(
.PAD        (SDATAIN1           ),
.pad_config (pad_config_SDATAIN1),
.pad_in     (pad_in_SDATAIN1    ),
.pad_oen    (pad_oen_SDATAIN1   ),
.pad_out    (pad_out_SDATAIN1   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAOUT1
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sdataout1       IO:O
// Function1        :gpio3           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in13     IO:I
//----------------------------------------------------------------
wire pad_in_SDATAOUT1;
wire pad_oen_SDATAOUT1;
wire pad_out_SDATAOUT1;

assign edt_ch_in13_i = pad_sel_SDATAOUT1==SEL_SCAN ? pad_in_SDATAOUT1 : 1'b1;
assign gpio3_i = pad_sel_SDATAOUT1==SEL_FUNC1 ? pad_in_SDATAOUT1 : 1'b1;

assign pad_oen_SDATAOUT1 = pad_sel_SDATAOUT1==SEL_FUNC1 ? gpio3_oen :
						pad_sel_SDATAOUT1==SEL_FUNC0 ? sdataout1_oen :
						1'b1;
assign pad_out_SDATAOUT1 = pad_sel_SDATAOUT1==SEL_FUNC1 ? gpio3_o :
						pad_sel_SDATAOUT1==SEL_FUNC0 ? sdataout1_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SDATAOUT1(
.PAD        (SDATAOUT1           ),
.pad_config (pad_config_SDATAOUT1),
.pad_in     (pad_in_SDATAOUT1    ),
.pad_oen    (pad_oen_SDATAOUT1   ),
.pad_out    (pad_out_SDATAOUT1   )
);

//----------------------------------------------------------------
// PAD_NAME         :SCLOCK2
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sclock2         IO:O
// Function1        :gpio4           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in14     IO:I
//----------------------------------------------------------------
wire pad_in_SCLOCK2;
wire pad_oen_SCLOCK2;
wire pad_out_SCLOCK2;

assign edt_ch_in14_i = pad_sel_SCLOCK2==SEL_SCAN ? pad_in_SCLOCK2 : 1'b1;
assign gpio4_i = pad_sel_SCLOCK2==SEL_FUNC1 ? pad_in_SCLOCK2 : 1'b1;

assign pad_oen_SCLOCK2 = pad_sel_SCLOCK2==SEL_FUNC1 ? gpio4_oen :
						pad_sel_SCLOCK2==SEL_FUNC0 ? sclock2_oen :
						1'b1;
assign pad_out_SCLOCK2 = pad_sel_SCLOCK2==SEL_FUNC1 ? gpio4_o :
						pad_sel_SCLOCK2==SEL_FUNC0 ? sclock2_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SCLOCK2(
.PAD        (SCLOCK2           ),
.pad_config (pad_config_SCLOCK2),
.pad_in     (pad_in_SCLOCK2    ),
.pad_oen    (pad_oen_SCLOCK2   ),
.pad_out    (pad_out_SCLOCK2   )
);

//----------------------------------------------------------------
// PAD_NAME         :SLOAD2
// TYPE             :IO
// CELL_NAME        :PDDWUW0408DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sload2          IO:O
// Function1        :gpio5           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in15     IO:I
//----------------------------------------------------------------
wire pad_in_SLOAD2;
wire pad_oen_SLOAD2;
wire pad_out_SLOAD2;

assign edt_ch_in15_i = pad_sel_SLOAD2==SEL_SCAN ? pad_in_SLOAD2 : 1'b1;
assign gpio5_i = pad_sel_SLOAD2==SEL_FUNC1 ? pad_in_SLOAD2 : 1'b1;

assign pad_oen_SLOAD2 = pad_sel_SLOAD2==SEL_FUNC1 ? gpio5_oen :
						pad_sel_SLOAD2==SEL_FUNC0 ? sload2_oen :
						1'b1;
assign pad_out_SLOAD2 = pad_sel_SLOAD2==SEL_FUNC1 ? gpio5_o :
						pad_sel_SLOAD2==SEL_FUNC0 ? sload2_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SLOAD2(
.PAD        (SLOAD2           ),
.pad_config (pad_config_SLOAD2),
.pad_in     (pad_in_SLOAD2    ),
.pad_oen    (pad_oen_SLOAD2   ),
.pad_out    (pad_out_SLOAD2   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAIN2
// TYPE             :IO
// CELL_NAME        :PRDWUW1216DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sdatain2        IO:I
// Function1        :gpio6           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in16     IO:I
//----------------------------------------------------------------
wire pad_in_SDATAIN2;
wire pad_oen_SDATAIN2;
wire pad_out_SDATAIN2;

assign edt_ch_in16_i = pad_sel_SDATAIN2==SEL_SCAN ? pad_in_SDATAIN2 : 1'b1;
assign gpio6_i = pad_sel_SDATAIN2==SEL_FUNC1 ? pad_in_SDATAIN2 : 1'b1;
assign sdatain2_i = pad_sel_SDATAIN2==SEL_FUNC0 ? pad_in_SDATAIN2 : 1'b1;

assign pad_oen_SDATAIN2 = gpio6_oen;
assign pad_out_SDATAIN2 = gpio6_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SDATAIN2(
.PAD        (SDATAIN2           ),
.pad_config (pad_config_SDATAIN2),
.pad_in     (pad_in_SDATAIN2    ),
.pad_oen    (pad_oen_SDATAIN2   ),
.pad_out    (pad_out_SDATAIN2   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAOUT2
// TYPE             :IO
// CELL_NAME        :PRDWUW1216DGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :1
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :sdataout2       IO:O
// Function1        :gpio7           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in17     IO:I
//----------------------------------------------------------------
wire pad_in_SDATAOUT2;
wire pad_oen_SDATAOUT2;
wire pad_out_SDATAOUT2;

assign edt_ch_in17_i = pad_sel_SDATAOUT2==SEL_SCAN ? pad_in_SDATAOUT2 : 1'b1;
assign gpio7_i = pad_sel_SDATAOUT2==SEL_FUNC1 ? pad_in_SDATAOUT2 : 1'b1;

assign pad_oen_SDATAOUT2 = pad_sel_SDATAOUT2==SEL_FUNC1 ? gpio7_oen :
						pad_sel_SDATAOUT2==SEL_FUNC0 ? sdataout2_oen :
						1'b1;
assign pad_out_SDATAOUT2 = pad_sel_SDATAOUT2==SEL_FUNC1 ? gpio7_o :
						pad_sel_SDATAOUT2==SEL_FUNC0 ? sdataout2_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 1 ),
.SCHMITT_TRIGGER  ( 0 )
)u_SDATAOUT2(
.PAD        (SDATAOUT2           ),
.pad_config (pad_config_SDATAOUT2),
.pad_in     (pad_in_SDATAOUT2    ),
.pad_oen    (pad_oen_SDATAOUT2   ),
.pad_out    (pad_out_SDATAOUT2   )
);

//----------------------------------------------------------------
// PAD_NAME         :SCLOCK3
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sclock3         IO:O
// Function1        :gpio8           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in18     IO:I
//----------------------------------------------------------------
wire pad_in_SCLOCK3;
wire pad_oen_SCLOCK3;
wire pad_out_SCLOCK3;

assign edt_ch_in18_i = pad_sel_SCLOCK3==SEL_SCAN ? pad_in_SCLOCK3 : 1'b1;
assign gpio8_i = pad_sel_SCLOCK3==SEL_FUNC1 ? pad_in_SCLOCK3 : 1'b1;

assign pad_oen_SCLOCK3 = pad_sel_SCLOCK3==SEL_FUNC1 ? gpio8_oen :
						pad_sel_SCLOCK3==SEL_FUNC0 ? sclock3_oen :
						1'b1;
assign pad_out_SCLOCK3 = pad_sel_SCLOCK3==SEL_FUNC1 ? gpio8_o :
						pad_sel_SCLOCK3==SEL_FUNC0 ? sclock3_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SCLOCK3(
.PAD        (SCLOCK3           ),
.pad_config (pad_config_SCLOCK3),
.pad_in     (pad_in_SCLOCK3    ),
.pad_oen    (pad_oen_SCLOCK3   ),
.pad_out    (pad_out_SCLOCK3   )
);

//----------------------------------------------------------------
// PAD_NAME         :SLOAD3
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sload3          IO:O
// Function1        :gpio9           IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in19     IO:I
//----------------------------------------------------------------
wire pad_in_SLOAD3;
wire pad_oen_SLOAD3;
wire pad_out_SLOAD3;

assign edt_ch_in19_i = pad_sel_SLOAD3==SEL_SCAN ? pad_in_SLOAD3 : 1'b1;
assign gpio9_i = pad_sel_SLOAD3==SEL_FUNC1 ? pad_in_SLOAD3 : 1'b1;

assign pad_oen_SLOAD3 = pad_sel_SLOAD3==SEL_FUNC1 ? gpio9_oen :
						pad_sel_SLOAD3==SEL_FUNC0 ? sload3_oen :
						1'b1;
assign pad_out_SLOAD3 = pad_sel_SLOAD3==SEL_FUNC1 ? gpio9_o :
						pad_sel_SLOAD3==SEL_FUNC0 ? sload3_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SLOAD3(
.PAD        (SLOAD3           ),
.pad_config (pad_config_SLOAD3),
.pad_in     (pad_in_SLOAD3    ),
.pad_oen    (pad_oen_SLOAD3   ),
.pad_out    (pad_out_SLOAD3   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAIN3
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sdatain3        IO:I
// Function1        :gpio10          IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in20     IO:I
//----------------------------------------------------------------
wire pad_in_SDATAIN3;
wire pad_oen_SDATAIN3;
wire pad_out_SDATAIN3;

assign edt_ch_in20_i = pad_sel_SDATAIN3==SEL_SCAN ? pad_in_SDATAIN3 : 1'b1;
assign gpio10_i = pad_sel_SDATAIN3==SEL_FUNC1 ? pad_in_SDATAIN3 : 1'b1;
assign sdatain3_i = pad_sel_SDATAIN3==SEL_FUNC0 ? pad_in_SDATAIN3 : 1'b1;

assign pad_oen_SDATAIN3 = gpio10_oen;
assign pad_out_SDATAIN3 = gpio10_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SDATAIN3(
.PAD        (SDATAIN3           ),
.pad_config (pad_config_SDATAIN3),
.pad_in     (pad_in_SDATAIN3    ),
.pad_oen    (pad_oen_SDATAIN3   ),
.pad_out    (pad_out_SDATAIN3   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDATAOUT3
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sdataout3       IO:O
// Function1        :gpio11          IO:IO
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_in21     IO:I
//----------------------------------------------------------------
wire pad_in_SDATAOUT3;
wire pad_oen_SDATAOUT3;
wire pad_out_SDATAOUT3;

assign edt_ch_in21_i = pad_sel_SDATAOUT3==SEL_SCAN ? pad_in_SDATAOUT3 : 1'b1;
assign gpio11_i = pad_sel_SDATAOUT3==SEL_FUNC1 ? pad_in_SDATAOUT3 : 1'b1;

assign pad_oen_SDATAOUT3 = pad_sel_SDATAOUT3==SEL_FUNC1 ? gpio11_oen :
						pad_sel_SDATAOUT3==SEL_FUNC0 ? sdataout3_oen :
						1'b1;
assign pad_out_SDATAOUT3 = pad_sel_SDATAOUT3==SEL_FUNC1 ? gpio11_o :
						pad_sel_SDATAOUT3==SEL_FUNC0 ? sdataout3_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SDATAOUT3(
.PAD        (SDATAOUT3           ),
.pad_config (pad_config_SDATAOUT3),
.pad_in     (pad_in_SDATAOUT3    ),
.pad_oen    (pad_oen_SDATAOUT3   ),
.pad_out    (pad_out_SDATAOUT3   )
);

//----------------------------------------------------------------
// PAD_NAME         :SMCLK
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :smclk           IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_out0     IO:O
//----------------------------------------------------------------
wire pad_in_SMCLK;
wire pad_oen_SMCLK;
wire pad_out_SMCLK;

assign smclk_i = pad_sel_SMCLK==SEL_FUNC0 ? pad_in_SMCLK : 1'b1;

assign pad_oen_SMCLK = pad_sel_SMCLK==SEL_SCAN ? edt_ch_out0_oen :
						pad_sel_SMCLK==SEL_FUNC0 ? smclk_oen :
						1'b1;
assign pad_out_SMCLK = pad_sel_SMCLK==SEL_SCAN ? edt_ch_out0_o :
						pad_sel_SMCLK==SEL_FUNC0 ? smclk_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SMCLK(
.PAD        (SMCLK           ),
.pad_config (pad_config_SMCLK),
.pad_in     (pad_in_SMCLK    ),
.pad_oen    (pad_oen_SMCLK   ),
.pad_out    (pad_out_SMCLK   )
);

//----------------------------------------------------------------
// PAD_NAME         :SMDATA
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :smdata          IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_out1     IO:O
//----------------------------------------------------------------
wire pad_in_SMDATA;
wire pad_oen_SMDATA;
wire pad_out_SMDATA;

assign smdata_i = pad_sel_SMDATA==SEL_FUNC0 ? pad_in_SMDATA : 1'b1;

assign pad_oen_SMDATA = pad_sel_SMDATA==SEL_SCAN ? edt_ch_out1_oen :
						pad_sel_SMDATA==SEL_FUNC0 ? smdata_oen :
						1'b1;
assign pad_out_SMDATA = pad_sel_SMDATA==SEL_SCAN ? edt_ch_out1_o :
						pad_sel_SMDATA==SEL_FUNC0 ? smdata_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SMDATA(
.PAD        (SMDATA           ),
.pad_config (pad_config_SMDATA),
.pad_in     (pad_in_SMDATA    ),
.pad_oen    (pad_oen_SMDATA   ),
.pad_out    (pad_out_SMDATA   )
);

//----------------------------------------------------------------
// PAD_NAME         :SCL0
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :scl0            IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_out2     IO:O
//----------------------------------------------------------------
wire pad_in_SCL0;
wire pad_oen_SCL0;
wire pad_out_SCL0;

assign scl0_i = pad_sel_SCL0==SEL_FUNC0 ? pad_in_SCL0 : 1'b1;

assign pad_oen_SCL0 = pad_sel_SCL0==SEL_SCAN ? edt_ch_out2_oen :
						pad_sel_SCL0==SEL_FUNC0 ? scl0_oen :
						1'b1;
assign pad_out_SCL0 = pad_sel_SCL0==SEL_SCAN ? edt_ch_out2_o :
						pad_sel_SCL0==SEL_FUNC0 ? scl0_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SCL0(
.PAD        (SCL0           ),
.pad_config (pad_config_SCL0),
.pad_in     (pad_in_SCL0    ),
.pad_oen    (pad_oen_SCL0   ),
.pad_out    (pad_out_SCL0   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDA0
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sda0            IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_out3     IO:O
//----------------------------------------------------------------
wire pad_in_SDA0;
wire pad_oen_SDA0;
wire pad_out_SDA0;

assign sda0_i = pad_sel_SDA0==SEL_FUNC0 ? pad_in_SDA0 : 1'b1;

assign pad_oen_SDA0 = pad_sel_SDA0==SEL_SCAN ? edt_ch_out3_oen :
						pad_sel_SDA0==SEL_FUNC0 ? sda0_oen :
						1'b1;
assign pad_out_SDA0 = pad_sel_SDA0==SEL_SCAN ? edt_ch_out3_o :
						pad_sel_SDA0==SEL_FUNC0 ? sda0_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SDA0(
.PAD        (SDA0           ),
.pad_config (pad_config_SDA0),
.pad_in     (pad_in_SDA0    ),
.pad_oen    (pad_oen_SDA0   ),
.pad_out    (pad_out_SDA0   )
);

//----------------------------------------------------------------
// PAD_NAME         :SCL2
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :scl2            IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_SCL2;
wire pad_oen_SCL2;
wire pad_out_SCL2;

assign scl2_i = pad_in_SCL2;

assign pad_oen_SCL2 = scl2_oen;
assign pad_out_SCL2 = scl2_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SCL2(
.PAD        (SCL2           ),
.pad_config (pad_config_SCL2),
.pad_in     (pad_in_SCL2    ),
.pad_oen    (pad_oen_SCL2   ),
.pad_out    (pad_out_SCL2   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDA2
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sda2            IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_SDA2;
wire pad_oen_SDA2;
wire pad_out_SDA2;

assign sda2_i = pad_in_SDA2;

assign pad_oen_SDA2 = sda2_oen;
assign pad_out_SDA2 = sda2_o;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SDA2(
.PAD        (SDA2           ),
.pad_config (pad_config_SDA2),
.pad_in     (pad_in_SDA2    ),
.pad_oen    (pad_oen_SDA2   ),
.pad_out    (pad_out_SDA2   )
);

//----------------------------------------------------------------
// PAD_NAME         :SCL3
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :scl3            IO:IO
// Function1        :None            IO:None
// Function2        :sas8_perstn     IO:O
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_SCL3;
wire pad_oen_SCL3;
wire pad_out_SCL3;

assign scl3_i = pad_sel_SCL3==SEL_FUNC0 ? pad_in_SCL3 : 1'b1;

assign pad_oen_SCL3 = pad_sel_SCL3==SEL_FUNC2 ? sas8_perstn_oen :
						pad_sel_SCL3==SEL_FUNC0 ? scl3_oen :
						1'b1;
assign pad_out_SCL3 = pad_sel_SCL3==SEL_FUNC2 ? sas8_perstn_o :
						pad_sel_SCL3==SEL_FUNC0 ? scl3_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SCL3(
.PAD        (SCL3           ),
.pad_config (pad_config_SCL3),
.pad_in     (pad_in_SCL3    ),
.pad_oen    (pad_oen_SCL3   ),
.pad_out    (pad_out_SCL3   )
);

//----------------------------------------------------------------
// PAD_NAME         :SDA3
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :sda3            IO:IO
// Function1        :None            IO:None
// Function2        :sas9_perstn     IO:O
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
wire pad_in_SDA3;
wire pad_oen_SDA3;
wire pad_out_SDA3;

assign sda3_i = pad_sel_SDA3==SEL_FUNC0 ? pad_in_SDA3 : 1'b1;

assign pad_oen_SDA3 = pad_sel_SDA3==SEL_FUNC2 ? sas9_perstn_oen :
						pad_sel_SDA3==SEL_FUNC0 ? sda3_oen :
						1'b1;
assign pad_out_SDA3 = pad_sel_SDA3==SEL_FUNC2 ? sas9_perstn_o :
						pad_sel_SDA3==SEL_FUNC0 ? sda3_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_SDA3(
.PAD        (SDA3           ),
.pad_config (pad_config_SDA3),
.pad_in     (pad_in_SDA3    ),
.pad_oen    (pad_oen_SDA3   ),
.pad_out    (pad_out_SDA3   )
);

//----------------------------------------------------------------
// PAD_NAME         :RGMII_MDC
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :rgmii_mdc       IO:O
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_out4     IO:O
//----------------------------------------------------------------
wire pad_in_RGMII_MDC;
wire pad_oen_RGMII_MDC;
wire pad_out_RGMII_MDC;

assign pad_oen_RGMII_MDC = pad_sel_RGMII_MDC==SEL_SCAN ? edt_ch_out4_oen :
						pad_sel_RGMII_MDC==SEL_FUNC0 ? rgmii_mdc_oen :
						1'b1;
assign pad_out_RGMII_MDC = pad_sel_RGMII_MDC==SEL_SCAN ? edt_ch_out4_o :
						pad_sel_RGMII_MDC==SEL_FUNC0 ? rgmii_mdc_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_RGMII_MDC(
.PAD        (RGMII_MDC           ),
.pad_config (pad_config_RGMII_MDC),
.pad_in     (pad_in_RGMII_MDC    ),
.pad_oen    (pad_oen_RGMII_MDC   ),
.pad_out    (pad_out_RGMII_MDC   )
);

//----------------------------------------------------------------
// PAD_NAME         :RGMII_MDIO
// TYPE             :IO
// CELL_NAME        :PDDWUW0408SDGH_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :1
//------------------------------------------
// Function0        :rgmii_mdio      IO:IO
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :edt_ch_out5     IO:O
//----------------------------------------------------------------
wire pad_in_RGMII_MDIO;
wire pad_oen_RGMII_MDIO;
wire pad_out_RGMII_MDIO;

assign rgmii_mdio_i = pad_sel_RGMII_MDIO==SEL_FUNC0 ? pad_in_RGMII_MDIO : 1'b1;

assign pad_oen_RGMII_MDIO = pad_sel_RGMII_MDIO==SEL_SCAN ? edt_ch_out5_oen :
						pad_sel_RGMII_MDIO==SEL_FUNC0 ? rgmii_mdio_oen :
						1'b1;
assign pad_out_RGMII_MDIO = pad_sel_RGMII_MDIO==SEL_SCAN ? edt_ch_out5_o :
						pad_sel_RGMII_MDIO==SEL_FUNC0 ? rgmii_mdio_o :
						1'b1;

xs_io #(
.PHY_DIR          ( 0 ),
.LMIT_SLEW_RATE   ( 0 ),
.SCHMITT_TRIGGER  ( 1 )
)u_RGMII_MDIO(
.PAD        (RGMII_MDIO           ),
.pad_config (pad_config_RGMII_MDIO),
.pad_in     (pad_in_RGMII_MDIO    ),
.pad_oen    (pad_oen_RGMII_MDIO   ),
.pad_out    (pad_out_RGMII_MDIO   )
);

//----------------------------------------------------------------
// PAD_NAME         :XI
// TYPE             :CRYSTAL
// CELL_NAME        :PDXOEDG8E_H
// Direction        :EW
// LMIT_SLEW_RATE   :0
// SCHMITT_TRIGGER  :0
//------------------------------------------
// Function0        :clk_25m         IO:I
// Function1        :None            IO:None
// Function2        :None            IO:None
// Function3        :None            IO:None
// Test_mode        :None            IO:None
// Scan_mode        :None            IO:None
//----------------------------------------------------------------
xs_crystal_io #(
.PHY_DIR(0)
)u_XI(
.XIN        (XI           ),
.XOUT       (XO           ),
.pad_config (pad_config_XI),
.pad_in     (clk_25m_i    )
);

endmodule
