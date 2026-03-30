module io_wrapper #(
    parameter PHY_DIR = 0, //0-H,1-V
    parameter LMIT_SLEW_RATE = 0 //0-pdd io cell,1-prd io cell
    parameter SCHMITT_TRIGGER = 0 //0-disable,1-enable
)(
    //pad
    inout       PAD,
    //input signals
    input       i_data_in,
    input       i_data_oen,
    input       i_data_ie,
    input       i_ds,
    input       i_pull_up,
    input       i_pull_down,
    //output signals
    output      o_data_out
);