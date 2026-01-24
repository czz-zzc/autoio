//pad_sel[3:0] 4'b0000 :function 0 
//pad_sel[3:0] 4'b0001 :function 1 
//pad_sel[3:0] 4'b0010 :function 2
//pad_sel[3:0] 4'b0011 :function 3
//pad_sel[3:0] 4'b0100 :scan mode
//pad_sel[3:0] 4'b1000 :test mode
//pad_sel[3:0] others  :reserved

module io_top(
//PAD definition
    input       XI,
    output      XO,
    inout       JTAG_TCK,
    inout       SMDATA,
    inout       SLOAD1,
//IO configuration
    input [3:0] pad_config_XI, 
    input [3:0] pad_config_JTAG_TCK,
    input [3:0] pad_config_SMDATA, 
    input [3:0] pad_config_SLOAD1, 
//IO selection
    input [3:0] pad_sel_JTAG_TCK,
    input [3:0] pad_sel_SMDATA,  
    input [3:0] pad_sel_SLOAD1, 
//function 0
    output      clk_25m_i,
    output      jtag_tck_i,
    output      smdata_i,
    input       smdata_o,
    input       smdata_oen,
    output      sload1_i,
//function 1    
    output      gpio1_i,
    input       gpio1_o,
    input       gpio1_oen,
//function 2
//function 3
//test mode
    output      ijtag_tck_i,
//scan mode    
    input       edt_ch_in11_o,
    input       edt_ch_in11_oen
);


//----------------------------------------------------------------
// PAD_NAME	:XI/XO
// TYPE		:crystal
// Direction:EW
// Function0:XI			IO:I
// Function1:None		IO:None
// Function2:None		IO:None
// Function3:None		IO:None
// Test_mode:None       IO:None
// Scan_mode:None       IO:None
//----------------------------------------------------------------
xs_crystal_io #(
.PHY_DIR(0)
)u_XI(
.XIN		(XI				),
.XOUT		(XO				),
.pad_config	(pad_config_XI	),
.pad_out    (clk_25m_i		)
);


//----------------------------------------------------------------
// PAD_NAME	:JTAG_TCK
// TYPE		:IO
// Direction:NS
// Function0:jtag_tck	IO:I
// Function1:None		IO:None
// Function2:None		IO:None
// Function3:None		IO:None
// Test_mode:ijtag_tck	IO:I
// Scan_mode:None       IO:None
//----------------------------------------------------------------
wire pad_in_JTAG_TCK;
wire pad_oen_JTAG_TCK;
wire pad_out_JTAG_TCK;

assign jtag_tck_i  = pad_sel_JTAG_TCK[3:0]==4'b0000 ? pad_in_JTAG_TCK : 1'b1;
assign ijtag_tck_i = pad_sel_JTAG_TCK[3:0]==4'b1000 ? pad_in_JTAG_TCK : 1'b1;

assign pad_oen_JTAG_TCK = 1'b1; //always disable output
assign pad_out_JTAG_TCK = 1'b0; //not used
xs_io #(
.PHY_DIR(1),
)u_JTAG_TCK(
.PAD		(JTAG_TCK				),
.pad_config	(pad_config_JTAG_TCK	),
.pad_in  	(pad_in_JTAG_TCK		),
.pad_oen    (pad_oen_JTAG_TCK		),
.pad_out	(pad_out_JTAG_TCK		)
);


//----------------------------------------------------------------
// PAD_NAME	:SMDATA
// TYPE		:IO
// Direction:EW
// Function0:smdata	            IO:IO
// Function1:None		        IO:None
// Function2:None		        IO:None
// Function3:None		        IO:None
// Test_mode:None	            IO:O
// Scan_mode:edt_ch_out1        IO:None
//----------------------------------------------------------------
wire pad_in_SMDATA;
wire pad_oen_SMDATA;
wire pad_out_SMDATA;

assign smdata_i  = pad_sel_SMDATA[3:0]==4'b0000 ? pad_in_SMDATA :1'b1;

assign pad_oen_SMDATA = pad_sel_SMDATA[3:0]==4'b0100 ? edt_ch_out1_oen : 
						pad_sel_SMDATA[3:0]==4'b0000 ? smdata_oen :
													   1'b1;
assign pad_out_SMDATA = pad_sel_SMDATA[3:0]==4'b0100 ? edt_ch_out1_o: 
						pad_sel_SMDATA[3:0]==4'b0000 ? smdata_o :
													   1'b1;

xs_io #(
.PHY_DIR(0),
)u_SMDATA(
.PAD		(SMDATA				),
.pad_config	(pad_config_SMDATA	),
.pad_in  	(pad_in_SMDATA		),
.pad_oen    (pad_oen_SMDATA		),
.pad_out	(pad_out_SMDATA		)
);

//----------------------------------------------------------------
// PAD_NAME	:SLOAD1
// TYPE		:IO
// Direction:EW
// Function0:sload1	            IO:O
// Function1:gpio1		        IO:IO
// Function2:None		        IO:None
// Function3:None		        IO:None
// Test_mode:None	            IO:None
// Scan_mode:edt_ch_in11        IO:I
//----------------------------------------------------------------
wire pad_in_SLOAD1;
wire pad_oen_SLOAD1;
wire pad_out_SLOAD1;

assign edt_ch_in11_i  = pad_sel_SLOAD1[3:0]== 4'b0100 ? pad_in_SLOAD1 : 1'b1;
assign gpio1_i  	  = pad_sel_SLOAD1[3:0]== 4'b0010 ? pad_in_SLOAD1 : 1'b1;

assign pad_oen_SLOAD1 = pad_sel_SLOAD1[3:0]== 4'b0010 ? gpio1_oen :
                        pad_sel_SLOAD1[3:0]== 4'b0000 ? sload1_oen:
														1'b1;

assign pad_out_SLOAD1 = pad_sel_SLOAD1[3:0]== 4'b0010 ? gpio1_o :
                        pad_sel_SLOAD1[3:0]== 4'b0000 ? sload1_o:
														1'b1;
						

xs_io #(
.PHY_DIR(0),
)u_SMDATA(
.PAD		(SLOAD1				),
.pad_config	(pad_config_SLOAD1	),
.pad_in  	(pad_in_SLOAD1		),
.pad_oen    (pad_oen_SLOAD1		),
.pad_out	(pad_out_SLOAD1		)
);
endmodule