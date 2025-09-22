module part5 (SW, LEDR, HEX2, HEX1, HEX0);
    input  [9:0] SW;        // input switches
    output [9:0] LEDR;      // red LEDs
    output [6:0] HEX2, HEX1, HEX0; // 7-seg outputs

    assign LEDR = SW;       // show switches on LEDs
    wire [1:0] M2, M1, M0;

    mux_2bit_3to1 mux2 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M2); 
    mux_2bit_3to1 mux1 (SW[9:8], SW[3:2], SW[1:0], SW[5:4], M1); 
    mux_2bit_3to1 mux0 (SW[9:8], SW[1:0], SW[5:4], SW[3:2], M0);
    // Decode selected codes into 7-seg display patterns
    char_7seg H2 (M2, HEX2);
    char_7seg H1 (M1, HEX1);
    char_7seg H0 (M0, HEX0);

endmodule


// ---------------------------------------------------------
// 2-bit wide 3-to-1 multiplexer
module mux_2bit_3to1 (S, U, V, W, M);
    input  [1:0] S, U, V, W;
    output reg [1:0] M;

    always @(*) begin
        case (S)
            2'b00: M = U;
            2'b01: M = V;
            2'b10: M = W;
            default: M = 2'b00; // blank for safety
        endcase
    end
endmodule

module char_7seg (C, Display);
    input  [1:0] C;
    output reg [6:0] Display;

    always @(*) begin
        case (C)
            2'b00: Display = 7'b0100001; // d
            2'b01: Display = 7'b0000110; // E
            2'b10: Display = 7'b1001111; // 1
            2'b11: Display = 7'b1111111; // blank
            default: Display = 7'b1111111;
        endcase
    end
endmodule
