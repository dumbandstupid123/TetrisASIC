//-----------------------------------------------------
// File Name   : tetris_fsm.v
// Tetris FSM Controller - Two Phase Clock Style
// Team: Memory Mafia
// Elec 422, Spring 2026
//-----------------------------------------------------
module tetris_fsm (clka, clkb, restart,
    btn_left, btn_right, btn_rotate, btn_drop,
    collision_flag, row_full_flag, game_over_flag,
    clear_done, gravity_tick,
    alu_op_shift_left, alu_op_shift_right,
    alu_op_rotate, alu_op_gravity,
    piece_lock, piece_spawn, clear_row,
    score_inc, board_reset,
    disp_row_valid, disp_row_addr,
    out_game_over, out_line_clear,
    state);

//----------Input Ports--------------------------------
input clka, clkb, restart;
input btn_left, btn_right, btn_rotate, btn_drop;
input collision_flag, row_full_flag, game_over_flag;
input clear_done, gravity_tick;

//----------Output Ports-------------------------------
output alu_op_shift_left, alu_op_shift_right;
output alu_op_rotate, alu_op_gravity;
output piece_lock, piece_spawn, clear_row;
output score_inc, board_reset;
output disp_row_valid;
output [3:0] disp_row_addr;
output out_game_over, out_line_clear;
output [3:0] state;

//----------Data Types---------------------------------
wire clka, clkb, restart;
wire btn_left, btn_right, btn_rotate, btn_drop;
wire collision_flag, row_full_flag, game_over_flag;
wire clear_done, gravity_tick;

reg alu_op_shift_left, alu_op_shift_right;
reg alu_op_rotate, alu_op_gravity;
reg piece_lock, piece_spawn, clear_row;
reg score_inc, board_reset;
reg disp_row_valid;
reg [3:0] disp_row_addr;
reg out_game_over, out_line_clear;

//----------State Parameters---------------------------
parameter SIZE = 4;
parameter [SIZE-1:0]
    IDLE        = 4'd0,
    SPAWN       = 4'd1,
    INPUT_POLL  = 4'd2,
    VALIDATE    = 4'd3,
    UPDATE      = 4'd4,
    LOCK        = 4'd5,
    CLEAR_CHECK = 4'd6,
    CLEAR_EXEC  = 4'd7,
    SCORE       = 4'd8,
    DISP_SCAN   = 4'd9,
    GAME_OVER   = 4'd10;

//----------Internal Variables-------------------------
reg  [SIZE-1:0] state;
wire [SIZE-1:0] temp_state;
reg  [SIZE-1:0] next_state;
reg  [2:0]      move_cmd;
reg  [3:0]      disp_cnt;

//----------Combinational Next-State Function----------
assign temp_state = fsm_function(state, 
    btn_left, btn_right, btn_rotate, btn_drop,
    collision_flag, row_full_flag, game_over_flag,
    clear_done, gravity_tick,
    move_cmd, disp_cnt);

function [SIZE-1:0] fsm_function;
    input [SIZE-1:0] state;
    input btn_left, btn_right, btn_rotate, btn_drop;
    input collision_flag, row_full_flag, game_over_flag;
    input clear_done, gravity_tick;
    input [2:0] move_cmd;
    input [3:0] disp_cnt;

    case (state)
        IDLE:       fsm_function = SPAWN;

        SPAWN:      fsm_function = INPUT_POLL;

        INPUT_POLL: begin
            if (btn_left | btn_right | btn_rotate | btn_drop | gravity_tick)
                fsm_function = VALIDATE;
            else
                fsm_function = INPUT_POLL;
        end

        VALIDATE:   fsm_function = UPDATE;

        UPDATE: begin
            if (collision_flag && (move_cmd == 3'b000))
                fsm_function = LOCK;
            else if (collision_flag)
                fsm_function = INPUT_POLL;
            else
                fsm_function = DISP_SCAN;
        end

        LOCK:       fsm_function = CLEAR_CHECK;

        CLEAR_CHECK: begin
            if (game_over_flag)
                fsm_function = GAME_OVER;
            else if (row_full_flag)
                fsm_function = CLEAR_EXEC;
            else
                fsm_function = SPAWN;
        end

        CLEAR_EXEC: begin
            if (clear_done)
                fsm_function = SCORE;
            else
                fsm_function = CLEAR_EXEC;
        end

        SCORE:      fsm_function = CLEAR_CHECK;

        DISP_SCAN: begin
            if (disp_cnt == 4'd15)
                fsm_function = INPUT_POLL;
            else
                fsm_function = DISP_SCAN;
        end

        GAME_OVER:  fsm_function = GAME_OVER;

        default:    fsm_function = IDLE;
    endcase
endfunction

//----------Sequential Logic - clka--------------------
always @ (negedge clka)
begin : FSM_SEQ
    if (restart == 1'b1) begin
        next_state <= IDLE;
        move_cmd   <= 3'b000;
        disp_cnt   <= 4'd0;
    end else begin
        next_state <= temp_state;
        // latch move command in INPUT_POLL
        if (state == INPUT_POLL) begin
            if      (btn_left)   move_cmd <= 3'b001;
            else if (btn_right)  move_cmd <= 3'b010;
            else if (btn_rotate) move_cmd <= 3'b100;
            else                 move_cmd <= 3'b000;
        end
        // advance display counter
        if (state == DISP_SCAN) begin
            if (disp_cnt == 4'd15) disp_cnt <= 4'd0;
            else                   disp_cnt <= disp_cnt + 1'b1;
        end else begin
            disp_cnt <= 4'd0;
        end
    end
end

//----------Output Logic - clkb------------------------
always @ (negedge clkb)
begin : OUTPUT_LOGIC
    // default outputs off
    alu_op_shift_left  <= 1'b0;
    alu_op_shift_right <= 1'b0;
    alu_op_rotate      <= 1'b0;
    alu_op_gravity     <= 1'b0;
    piece_lock         <= 1'b0;
    piece_spawn        <= 1'b0;
    clear_row          <= 1'b0;
    score_inc          <= 1'b0;
    board_reset        <= 1'b0;
    disp_row_valid     <= 1'b0;
    disp_row_addr      <= 4'd0;
    out_game_over      <= 1'b0;
    out_line_clear     <= 1'b0;

    case (next_state)
        IDLE: begin
            state       <= next_state;
            board_reset <= 1'b1;
        end
        SPAWN: begin
            state       <= next_state;
            piece_spawn <= 1'b1;
        end
        INPUT_POLL: begin
            state <= next_state;
        end
        VALIDATE: begin
            state <= next_state;
            case (move_cmd)
                3'b001: alu_op_shift_left  <= 1'b1;
                3'b010: alu_op_shift_right <= 1'b1;
                3'b100: alu_op_rotate      <= 1'b1;
                default: alu_op_gravity    <= 1'b1;
            endcase
        end
        UPDATE: begin
            state <= next_state;
        end
        LOCK: begin
            state      <= next_state;
            piece_lock <= 1'b1;
        end
        CLEAR_CHECK: begin
            state <= next_state;
        end
        CLEAR_EXEC: begin
            state          <= next_state;
            clear_row      <= 1'b1;
            out_line_clear <= 1'b1;
        end
        SCORE: begin
            state     <= next_state;
            score_inc <= 1'b1;
        end
        DISP_SCAN: begin
            state          <= next_state;
            disp_row_valid <= 1'b1;
            disp_row_addr  <= disp_cnt;
        end
        GAME_OVER: begin
            state         <= next_state;
            out_game_over <= 1'b1;
        end
        default: state <= IDLE;
    endcase
end

endmodule