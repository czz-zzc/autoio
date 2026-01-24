module xs_crystal_io #(
    parameter PHY_DIR = 0 //0-H,1-V
)(
    //pad
    input       XIN,
    output      XOUT,
    //input signals
    input [3:0] pad_config,//{xe,ds[2:0]}
    //output signals
    output      pad_in
);

    crystal_io_wrapper #(
        .PHY_DIR ( PHY_DIR )
    ) u_crystal_io_wrapper (
        .XIN    ( XIN             ),
        .XOUT   ( XOUT            ),
        .i_xe   ( pad_config[3]   ),
        .i_ds   ( pad_config[2:0] ),
        .o_xc   ( pad_in         )
    );

endmodule
