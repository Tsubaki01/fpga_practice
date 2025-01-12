module debounce (
    input CLK,
    input RST,
    input BTNIN,
    output reg BTNOUT
);

//γ―γ­γ?γ―ε?ε¨
reg [21:0] cnt22;

wire en40hz = (cnt22 == 22'd3125000-1);

always @(posedge CLK) begin
    if (RST)
        cnt22 <= 22'h0;
    else if (en40hz)
        cnt22 <= 22'h0;
    else
        cnt22 <= cnt22 + 22'h1;
end

//γΉγ€γ?γε?₯εγFFγ§εγεγ
reg ff1, ff2;

always @(posedge CLK) begin
    if (RST) begin
        ff1 <= 1'b0;
        ff2 <= 1'b0;
    end
    else if (en40hz) begin
        ff2 <= ff1;
        ff1 <= BTNIN;
    end
end

//η«γ‘δΈγγζ€ε?Ί
wire temp = ff1 & ~ff2 & en40hz;

always @(posedge CLK) begin
    if (RST)
        BTNOUT <= 1'b0;
    else
        BTNOUT <=temp;
end

endmodule