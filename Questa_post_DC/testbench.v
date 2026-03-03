`timescale 1ns/1ps
module tetris_fsm_tb;

reg clka, clkb, restart;
reg btn_left, btn_right, btn_rotate, btn_drop;
reg collision_flag, row_full_flag, game_over_flag;
reg clear_done, gravity_tick;

wire alu_op_shift_left, alu_op_shift_right;
wire alu_op_rotate, alu_op_gravity;
wire piece_lock, piece_spawn, clear_row;
wire score_inc, board_reset, disp_row_valid;
wire [3:0] disp_row_addr;
wire out_game_over, out_line_clear;
wire [3:0] state;

tetris_fsm uut (
    .clka(clka), .clkb(clkb), .restart(restart),
    .btn_left(btn_left), .btn_right(btn_right),
    .btn_rotate(btn_rotate), .btn_drop(btn_drop),
    .collision_flag(collision_flag),
    .row_full_flag(row_full_flag),
    .game_over_flag(game_over_flag),
    .clear_done(clear_done),
    .gravity_tick(gravity_tick),
    .alu_op_shift_left(alu_op_shift_left),
    .alu_op_shift_right(alu_op_shift_right),
    .alu_op_rotate(alu_op_rotate),
    .alu_op_gravity(alu_op_gravity),
    .piece_lock(piece_lock),
    .piece_spawn(piece_spawn),
    .clear_row(clear_row),
    .score_inc(score_inc),
    .board_reset(board_reset),
    .disp_row_valid(disp_row_valid),
    .disp_row_addr(disp_row_addr),
    .out_game_over(out_game_over),
    .out_line_clear(out_line_clear),
    .state(state)
);

// Two-phase non-overlapping clock
// clka: 0 1 0 0
// clkb: 0 0 0 1
// Each full cycle = 4 x 10ns = 40ns
task one_cycle;
begin
    clka=1; clkb=0; #10;   // clka high
    clka=0; clkb=0; #10;   // both low
    clka=0; clkb=1; #10;   // clkb high
    clka=0; clkb=0; #10;   // both low
end
endtask

initial begin
    $dumpfile("tetris_fsm_sim.vcd");
    $dumpvars(0, tetris_fsm_tb);
end

initial begin
    clka=0; clkb=0; restart=0;
    btn_left=0; btn_right=0; btn_rotate=0; btn_drop=0;
    collision_flag=0; row_full_flag=0; game_over_flag=0;
    clear_done=0; gravity_tick=0;

    // TEST 1: Reset
    $display("--- TEST 1: Restart ---");
    restart=1; one_cycle; restart=0;
    one_cycle;
    $display("  state=%0d piece_spawn=%b", state, piece_spawn);

    // TEST 2: Move left no collision
    $display("--- TEST 2: Move left, no collision ---");
    collision_flag=0;
    one_cycle;
    btn_left=1; one_cycle; btn_left=0;
    one_cycle; // VALIDATE
    one_cycle; // UPDATE
    $display("  alu_op_shift_left=%b state=%0d", alu_op_shift_left, state);
    repeat(18) one_cycle; // through DISP_SCAN

    // TEST 3: Move right, side collision rejected
    $display("--- TEST 3: Move right, collision rejected ---");
    collision_flag=1;
    btn_right=1; one_cycle; btn_right=0;
    one_cycle; one_cycle;
    collision_flag=0;
    $display("  state=%0d (expect INPUT_POLL=2)", state);

    // TEST 4: Gravity + downward collision -> LOCK
    $display("--- TEST 4: Gravity down collision -> LOCK ---");
    gravity_tick=1; one_cycle; gravity_tick=0;
    collision_flag=1; one_cycle; one_cycle;
    collision_flag=0;
    $display("  piece_lock=%b state=%0d", piece_lock, state);

    // TEST 5: Row full -> CLEAR_EXEC -> SCORE
    $display("--- TEST 5: Row clear ---");
    row_full_flag=1;
    one_cycle; one_cycle; one_cycle;
    clear_done=1; one_cycle; clear_done=0;
    row_full_flag=0;
    $display("  score_inc=%b", score_inc);
    repeat(3) one_cycle;

    // TEST 6: Game Over
    $display("--- TEST 6: Game Over ---");
    gravity_tick=1; one_cycle; gravity_tick=0;
    collision_flag=1; one_cycle; one_cycle;
    collision_flag=0;
    game_over_flag=1; one_cycle; one_cycle;
    $display("  out_game_over=%b (expect 1)", out_game_over);
    game_over_flag=0;
    restart=1; one_cycle; restart=0;
    one_cycle;
    $display("  out_game_over=%b after restart (expect 0)", out_game_over);

    // TEST 7: Display scan
    $display("--- TEST 7: Display scan ---");
    one_cycle;
    btn_left=1; one_cycle; btn_left=0;
    one_cycle; one_cycle;
    repeat(16) begin
        one_cycle;
        $display("  disp_row_addr=%0d valid=%b", disp_row_addr, disp_row_valid);
    end

    $display("=== All tests complete ===");
    #100 $finish;
end

endmodule