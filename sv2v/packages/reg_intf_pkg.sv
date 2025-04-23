
package reg_intf;

    /// 32 bit address, 32 bit data request package
    typedef struct packed {
        logic [31:0] addr;
        logic        write;
        logic [31:0] wdata;
        logic [3:0]  wstrb;
        logic        valid;
    } reg_intf_req_a32_d32;

    /// 32 bit address, 64 bit data request package
    typedef struct packed {
        logic [31:0] addr;
        logic        write;
        logic [63:0] wdata;
        logic [7:0]  wstrb;
        logic        valid;
    } reg_intf_req_a32_d64;

    /// 32 bit Response packages
    typedef struct packed {
        logic [31:0] rdata;
        logic        error;
        logic        ready;
    } reg_intf_resp_d32;

    /// 32 bit Response packages
    typedef struct packed {
        logic [63:0] rdata;
        logic        error;
        logic        ready;
    } reg_intf_resp_d64;

endpackage
