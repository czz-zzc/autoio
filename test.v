//==============================================================================
// File name    : test.v
// Description  : IO MUX module
// Generator    : autoio.py
// Author       : czz
// Generated on : 2026-01-24 18:48:00
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
    inout       JTAG_TCK,
    inout       SLOAD1,
    inout       SMDATA,
    //IO configuration
    input [3:0] pad_config_JTAG_TCK,
    input [3:0] pad_config_SLOAD1,
    input [3:0] pad_config_SMDATA,
    input [3:0] pad_config_XI,
    //IO selection
    input [3:0] pad_sel_JTAG_TCK,
    input [3:0] pad_sel_SLOAD1,
    input [3:0] pad_sel_SMDATA,
    //function 0
    output      jtag_tck_i,
    input       sload1_o,
    input       sload1_oen,
    input       smdata_o,
    input       smdata_oen,
    output      smdata_i,
    output      clk_25m_i,
    //function 1
    input       gpio1_o,
    input       gpio1_oen,
    output      gpio1_i,
    //test mode
    output      ijtag_tck_i,
    //scan mode
    output      edt_ch_in11_i,
    input       edt_ch_out1_o,
    input       edt_ch_out1_oen
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
// PAD_NAME	:JTAG_TCK
// TYPE		:IO
// Direction:NS
// Function0:jtag_tck        IO:I
// Function1:None            IO:None
// Function2:None            IO:None
// Function3:None            IO:None
// Test_mode:ijtag_tck       IO:I
// Scan_mode:None            IO:None
//----------------------------------------------------------------
wire pad_in_JTAG_TCK;
wire pad_oen_JTAG_TCK;
wire pad_out_JTAG_TCK;

assign ijtag_tck_i = pad_sel_JTAG_TCK==SEL_TEST ? pad_in_JTAG_TCK : 1'b1;
assign jtag_tck_i = pad_sel_JTAG_TCK==SEL_FUNC0 ? pad_in_JTAG_TCK : 1'b1;

assign pad_oen_JTAG_TCK = 1'b1; //always disable output
assign pad_out_JTAG_TCK = 1'b0;

xs_io #(
.PHY_DIR(1)
)u_JTAG_TCK(
.PAD        (JTAG_TCK           ),
.pad_config (pad_config_JTAG_TCK),
.pad_in     (pad_in_JTAG_TCK    ),
.pad_oen    (pad_oen_JTAG_TCK   ),
.pad_out    (pad_out_JTAG_TCK   )
);

//----------------------------------------------------------------
// PAD_NAME	:SLOAD1
// TYPE		:IO
// Direction:EW
// Function0:sload1          IO:O
// Function1:gpio1           IO:IO
// Function2:None            IO:None
// Function3:None            IO:None
// Test_mode:None            IO:None
// Scan_mode:edt_ch_in11     IO:I
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
.PHY_DIR(0)
)u_SLOAD1(
.PAD        (SLOAD1           ),
.pad_config (pad_config_SLOAD1),
.pad_in     (pad_in_SLOAD1    ),
.pad_oen    (pad_oen_SLOAD1   ),
.pad_out    (pad_out_SLOAD1   )
);

//----------------------------------------------------------------
// PAD_NAME	:SMDATA
// TYPE		:IO
// Direction:EW
// Function0:smdata          IO:IO
// Function1:None            IO:None
// Function2:None            IO:None
// Function3:gpio1           IO:IO
// Test_mode:None            IO:None
// Scan_mode:edt_ch_out1     IO:O
//----------------------------------------------------------------
wire pad_in_SMDATA;
wire pad_oen_SMDATA;
wire pad_out_SMDATA;

assign gpio1_i = pad_sel_SMDATA==SEL_FUNC3 ? pad_in_SMDATA : 1'b1;
assign smdata_i = pad_sel_SMDATA==SEL_FUNC0 ? pad_in_SMDATA : 1'b1;

assign pad_oen_SMDATA = pad_sel_SMDATA==SEL_SCAN ? edt_ch_out1_oen :
						pad_sel_SMDATA==SEL_FUNC3 ? gpio1_oen :
						pad_sel_SMDATA==SEL_FUNC0 ? smdata_oen :
						1'b1;
assign pad_out_SMDATA = pad_sel_SMDATA==SEL_SCAN ? edt_ch_out1_o :
						pad_sel_SMDATA==SEL_FUNC3 ? gpio1_o :
						pad_sel_SMDATA==SEL_FUNC0 ? smdata_o :
						1'b1;

xs_io #(
.PHY_DIR(0)
)u_SMDATA(
.PAD        (SMDATA           ),
.pad_config (pad_config_SMDATA),
.pad_in     (pad_in_SMDATA    ),
.pad_oen    (pad_oen_SMDATA   ),
.pad_out    (pad_out_SMDATA   )
);

//----------------------------------------------------------------
// PAD_NAME	:XI
// TYPE		:CRYSTAL
// Direction:EW
// Function0:clk_25m         IO:I
// Function1:None            IO:None
// Function2:None            IO:None
// Function3:None            IO:None
// Test_mode:None            IO:None
// Scan_mode:None            IO:None
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
