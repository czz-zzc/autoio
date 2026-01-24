module crystal_io_wrapper #(
    parameter PHY_DIR = 0 //0-H,1-V
)(
    //pad
    input       XIN,
    output      XOUT,
    //input signals
    input       i_xe,
    input [2:0] i_ds,

    //output signals
    output      o_xc
);
endmodule