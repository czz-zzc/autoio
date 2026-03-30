module xs_io #(
    parameter PHY_DIR = 0,         //0-H,1-V
    parameter LMIT_SLEW_RATE = 0,  //0-pdd io cell,1-prd io cell
    parameter SCHMITT_TRIGGER = 0 //0-Schmitt disable,1-enable
)(
    //pad
    inout       PAD,
    //input signals
    input       pad_out,
    input [3:0] pad_config,//{ie,pull_up,pull_down,ds}
    input       pad_oen, //0-enable,1-disable
    //output signals
    output      pad_in
);

    io_wrapper #(
        .PHY_DIR          ( PHY_DIR          ),
        .LMIT_SLEW_RATE   ( LMIT_SLEW_RATE   ),
        .SCHMITT_TRIGGER ( SCHMITT_TRIGGER )
    ) u_io_wrapper (
        .PAD              ( PAD              ),
        .i_data_in        ( pad_out          ),
        .i_data_oen       ( pad_oen          ),
        .i_data_ie        ( pad_config[3]    ),
        .i_pull_up        ( pad_config[2]    ),
        .i_pull_down      ( pad_config[1]    ),
        .i_ds             ( pad_config[0]    ),
        .o_data_out       ( pad_in           )
    );

endmodule
