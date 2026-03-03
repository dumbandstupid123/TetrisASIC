/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Mon Mar  2 17:44:13 2026
/////////////////////////////////////////////////////////////


module tetris_fsm ( clka, clkb, restart, btn_left, btn_right, btn_rotate, 
        btn_drop, collision_flag, row_full_flag, game_over_flag, clear_done, 
        gravity_tick, alu_op_shift_left, alu_op_shift_right, alu_op_rotate, 
        alu_op_gravity, piece_lock, piece_spawn, clear_row, score_inc, 
        board_reset, disp_row_valid, disp_row_addr, out_game_over, 
        out_line_clear, state );
  output [3:0] disp_row_addr;
  output [3:0] state;
  input clka, clkb, restart, btn_left, btn_right, btn_rotate, btn_drop,
         collision_flag, row_full_flag, game_over_flag, clear_done,
         gravity_tick;
  output alu_op_shift_left, alu_op_shift_right, alu_op_rotate, alu_op_gravity,
         piece_lock, piece_spawn, clear_row, score_inc, board_reset,
         disp_row_valid, out_game_over, out_line_clear;
  wire   \move_cmd[2]1 , \move_cmd[1]1 , \move_cmd[0]1 , \disp_cnt[3]1 ,
         \disp_cnt[2]1 , \disp_cnt[1]1 , \disp_cnt[0]1 , N126, N127, N129,
         N134, N135, N136, N137, N214, N215, N217, N218, N219, N220, N221,
         N222, N223, N224, N225, N226, N228, N229, N230, N231, N232, n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105;
  wire   [3:0] next_state;

  DFFNEGX1 \state_reg[0]  ( .D(N214), .CLK(n105), .Q(state[0]) );
  DFFNEGX1 \next_state_reg[1]  ( .D(N127), .CLK(clka), .Q(next_state[1]) );
  DFFNEGX1 \state_reg[1]  ( .D(N215), .CLK(n105), .Q(state[1]) );
  DFFNEGX1 \move_cmd_reg[1]  ( .D(n102), .CLK(clka), .Q(\move_cmd[1]1 ) );
  DFFNEGX1 \move_cmd_reg[2]  ( .D(n101), .CLK(clka), .Q(\move_cmd[2]1 ) );
  DFFNEGX1 \move_cmd_reg[0]  ( .D(n103), .CLK(clka), .Q(\move_cmd[0]1 ) );
  DFFNEGX1 \next_state_reg[0]  ( .D(N126), .CLK(clka), .Q(next_state[0]) );
  DFFNEGX1 \state_reg[3]  ( .D(N217), .CLK(n105), .Q(state[3]) );
  DFFNEGX1 \next_state_reg[2]  ( .D(n17), .CLK(clka), .Q(next_state[2]) );
  DFFNEGX1 out_line_clear_reg ( .D(N225), .CLK(n105), .Q(out_line_clear) );
  DFFNEGX1 \state_reg[2]  ( .D(n7), .CLK(n105), .Q(state[2]) );
  DFFNEGX1 \disp_cnt_reg[0]  ( .D(N134), .CLK(clka), .Q(\disp_cnt[0]1 ) );
  DFFNEGX1 \disp_cnt_reg[1]  ( .D(N135), .CLK(clka), .Q(\disp_cnt[1]1 ) );
  DFFNEGX1 \disp_cnt_reg[2]  ( .D(N136), .CLK(clka), .Q(\disp_cnt[2]1 ) );
  DFFNEGX1 \disp_cnt_reg[3]  ( .D(N137), .CLK(clka), .Q(\disp_cnt[3]1 ) );
  DFFNEGX1 \next_state_reg[3]  ( .D(N129), .CLK(clka), .Q(next_state[3]) );
  DFFNEGX1 alu_op_shift_left_reg ( .D(N221), .CLK(n105), .Q(alu_op_shift_left)
         );
  DFFNEGX1 alu_op_shift_right_reg ( .D(N222), .CLK(n105), .Q(
        alu_op_shift_right) );
  DFFNEGX1 alu_op_rotate_reg ( .D(N223), .CLK(n105), .Q(alu_op_rotate) );
  DFFNEGX1 alu_op_gravity_reg ( .D(N220), .CLK(n105), .Q(alu_op_gravity) );
  DFFNEGX1 piece_lock_reg ( .D(N224), .CLK(n105), .Q(piece_lock) );
  DFFNEGX1 piece_spawn_reg ( .D(N219), .CLK(n105), .Q(piece_spawn) );
  DFFNEGX1 clear_row_reg ( .D(N225), .CLK(n105), .Q(clear_row) );
  DFFNEGX1 score_inc_reg ( .D(N226), .CLK(n105), .Q(score_inc) );
  DFFNEGX1 board_reset_reg ( .D(N218), .CLK(n105), .Q(board_reset) );
  DFFNEGX1 disp_row_valid_reg ( .D(n6), .CLK(n105), .Q(disp_row_valid) );
  DFFNEGX1 \disp_row_addr_reg[3]  ( .D(N231), .CLK(n105), .Q(disp_row_addr[3])
         );
  DFFNEGX1 \disp_row_addr_reg[2]  ( .D(N230), .CLK(n105), .Q(disp_row_addr[2])
         );
  DFFNEGX1 \disp_row_addr_reg[1]  ( .D(N229), .CLK(n105), .Q(disp_row_addr[1])
         );
  DFFNEGX1 \disp_row_addr_reg[0]  ( .D(N228), .CLK(n105), .Q(disp_row_addr[0])
         );
  DFFNEGX1 out_game_over_reg ( .D(N232), .CLK(n105), .Q(out_game_over) );
  AND2X2 U3 ( .A(n6), .B(\disp_cnt[0]1 ), .Y(N228) );
  INVX2 U4 ( .A(n59), .Y(n1) );
  INVX2 U5 ( .A(n89), .Y(n2) );
  INVX2 U6 ( .A(\disp_cnt[3]1 ), .Y(n3) );
  INVX2 U7 ( .A(\disp_cnt[2]1 ), .Y(n4) );
  INVX2 U8 ( .A(\disp_cnt[1]1 ), .Y(n5) );
  INVX2 U9 ( .A(n44), .Y(n6) );
  INVX2 U10 ( .A(n48), .Y(n7) );
  INVX2 U11 ( .A(n51), .Y(n8) );
  INVX2 U12 ( .A(next_state[3]), .Y(n9) );
  INVX2 U13 ( .A(n45), .Y(n10) );
  INVX2 U14 ( .A(next_state[2]), .Y(n11) );
  INVX2 U15 ( .A(n47), .Y(n12) );
  INVX2 U16 ( .A(next_state[1]), .Y(n13) );
  INVX2 U17 ( .A(next_state[0]), .Y(n14) );
  INVX2 U18 ( .A(\move_cmd[2]1 ), .Y(n15) );
  INVX2 U19 ( .A(n99), .Y(n16) );
  INVX2 U20 ( .A(n73), .Y(n17) );
  INVX2 U21 ( .A(n87), .Y(n18) );
  INVX2 U22 ( .A(\move_cmd[1]1 ), .Y(n19) );
  INVX2 U23 ( .A(\move_cmd[0]1 ), .Y(n20) );
  INVX2 U24 ( .A(n66), .Y(n21) );
  INVX2 U25 ( .A(n71), .Y(n22) );
  INVX2 U26 ( .A(n83), .Y(n23) );
  INVX2 U27 ( .A(n68), .Y(n24) );
  INVX2 U28 ( .A(n39), .Y(n25) );
  INVX2 U29 ( .A(state[3]), .Y(n26) );
  INVX2 U30 ( .A(n42), .Y(n27) );
  INVX2 U31 ( .A(state[1]), .Y(n28) );
  INVX2 U32 ( .A(state[0]), .Y(n29) );
  INVX2 U33 ( .A(restart), .Y(n30) );
  INVX2 U34 ( .A(btn_left), .Y(n31) );
  INVX2 U35 ( .A(btn_right), .Y(n32) );
  INVX2 U36 ( .A(collision_flag), .Y(n33) );
  INVX2 U37 ( .A(row_full_flag), .Y(n34) );
  INVX2 U38 ( .A(game_over_flag), .Y(n35) );
  INVX2 U39 ( .A(clear_done), .Y(n36) );
  OAI21X1 U40 ( .A(n37), .B(n15), .C(n38), .Y(n101) );
  NAND3X1 U41 ( .A(n25), .B(n32), .C(btn_rotate), .Y(n38) );
  OAI22X1 U42 ( .A(n37), .B(n19), .C(n39), .D(n32), .Y(n102) );
  NAND3X1 U43 ( .A(n31), .B(n30), .C(n37), .Y(n39) );
  OAI21X1 U44 ( .A(n37), .B(n20), .C(n40), .Y(n103) );
  NAND3X1 U45 ( .A(n37), .B(n30), .C(btn_left), .Y(n40) );
  OAI21X1 U46 ( .A(n28), .B(n41), .C(n30), .Y(n37) );
  NAND2X1 U47 ( .A(n42), .B(n26), .Y(n41) );
  NOR2X1 U48 ( .A(n43), .B(n9), .Y(N232) );
  NOR2X1 U49 ( .A(n44), .B(n3), .Y(N231) );
  NOR2X1 U50 ( .A(n44), .B(n4), .Y(N230) );
  NOR2X1 U51 ( .A(n44), .B(n5), .Y(N229) );
  NAND3X1 U52 ( .A(n10), .B(next_state[3]), .C(next_state[0]), .Y(n44) );
  NOR2X1 U53 ( .A(n45), .B(n46), .Y(N226) );
  NAND2X1 U54 ( .A(next_state[3]), .B(n14), .Y(n46) );
  NOR2X1 U55 ( .A(n47), .B(n48), .Y(N225) );
  NOR2X1 U56 ( .A(n48), .B(n49), .Y(N224) );
  NAND2X1 U57 ( .A(next_state[0]), .B(n13), .Y(n49) );
  NOR2X1 U58 ( .A(n50), .B(n51), .Y(N223) );
  NOR2X1 U59 ( .A(n51), .B(n52), .Y(N222) );
  NOR2X1 U60 ( .A(n51), .B(n53), .Y(N221) );
  NOR2X1 U61 ( .A(n54), .B(n55), .Y(N220) );
  NAND2X1 U62 ( .A(n8), .B(n53), .Y(n55) );
  NAND3X1 U63 ( .A(n19), .B(n15), .C(\move_cmd[0]1 ), .Y(n53) );
  NAND3X1 U64 ( .A(n11), .B(n9), .C(n12), .Y(n51) );
  NAND2X1 U65 ( .A(n52), .B(n50), .Y(n54) );
  NAND3X1 U66 ( .A(n20), .B(n19), .C(\move_cmd[2]1 ), .Y(n50) );
  NAND3X1 U67 ( .A(n20), .B(n15), .C(\move_cmd[1]1 ), .Y(n52) );
  NOR2X1 U68 ( .A(n14), .B(n56), .Y(N219) );
  NAND2X1 U69 ( .A(n10), .B(n9), .Y(n56) );
  NOR2X1 U70 ( .A(n45), .B(n57), .Y(N218) );
  NAND2X1 U71 ( .A(n14), .B(n9), .Y(n57) );
  NOR2X1 U72 ( .A(n9), .B(n58), .Y(N217) );
  NAND2X1 U73 ( .A(n47), .B(n11), .Y(n58) );
  NAND2X1 U74 ( .A(next_state[0]), .B(next_state[1]), .Y(n47) );
  NAND2X1 U75 ( .A(next_state[2]), .B(n9), .Y(n48) );
  OAI21X1 U76 ( .A(next_state[3]), .B(n13), .C(n43), .Y(N215) );
  NAND3X1 U77 ( .A(n14), .B(n11), .C(next_state[1]), .Y(n43) );
  AOI21X1 U78 ( .A(next_state[3]), .B(n45), .C(n14), .Y(N214) );
  NAND2X1 U79 ( .A(n13), .B(n11), .Y(n45) );
  OAI22X1 U80 ( .A(n3), .B(n59), .C(n60), .D(n59), .Y(N137) );
  OAI21X1 U81 ( .A(n61), .B(n4), .C(n62), .Y(N136) );
  NAND3X1 U82 ( .A(n1), .B(\disp_cnt[0]1 ), .C(n63), .Y(n62) );
  NOR2X1 U83 ( .A(\disp_cnt[2]1 ), .B(n5), .Y(n63) );
  AOI21X1 U84 ( .A(n1), .B(n5), .C(N134), .Y(n61) );
  NOR2X1 U85 ( .A(n64), .B(n59), .Y(N135) );
  XOR2X1 U86 ( .A(\disp_cnt[0]1 ), .B(n5), .Y(n64) );
  NOR2X1 U87 ( .A(n59), .B(\disp_cnt[0]1 ), .Y(N134) );
  OAI21X1 U88 ( .A(restart), .B(n65), .C(n59), .Y(N129) );
  NAND3X1 U89 ( .A(n2), .B(n30), .C(n21), .Y(n59) );
  NOR2X1 U90 ( .A(n67), .B(n24), .Y(n65) );
  AOI22X1 U91 ( .A(n69), .B(game_over_flag), .C(n70), .D(clear_done), .Y(n68)
         );
  OAI21X1 U92 ( .A(collision_flag), .B(n71), .C(n72), .Y(n67) );
  NAND3X1 U93 ( .A(state[1]), .B(n42), .C(state[3]), .Y(n72) );
  OAI21X1 U94 ( .A(n74), .B(n75), .C(n30), .Y(n73) );
  OAI21X1 U95 ( .A(n34), .B(n76), .C(n77), .Y(n75) );
  NAND2X1 U96 ( .A(n69), .B(n35), .Y(n76) );
  OAI21X1 U97 ( .A(n26), .B(n78), .C(n79), .Y(n74) );
  NAND3X1 U98 ( .A(n80), .B(n26), .C(state[0]), .Y(n79) );
  XOR2X1 U99 ( .A(state[2]), .B(state[1]), .Y(n80) );
  NAND2X1 U100 ( .A(n42), .B(n28), .Y(n78) );
  AOI21X1 U101 ( .A(n81), .B(n82), .C(restart), .Y(N127) );
  AOI21X1 U102 ( .A(n42), .B(n83), .C(n84), .Y(n82) );
  OAI21X1 U103 ( .A(n33), .B(n85), .C(n86), .Y(n84) );
  OAI21X1 U104 ( .A(game_over_flag), .B(row_full_flag), .C(n69), .Y(n86) );
  NAND2X1 U105 ( .A(n22), .B(n87), .Y(n85) );
  AOI21X1 U106 ( .A(n70), .B(n36), .C(n88), .Y(n81) );
  OAI22X1 U107 ( .A(n66), .B(n2), .C(n29), .D(n83), .Y(n88) );
  AOI21X1 U108 ( .A(n16), .B(n90), .C(restart), .Y(N126) );
  AOI21X1 U109 ( .A(n69), .B(n35), .C(n91), .Y(n90) );
  OAI22X1 U110 ( .A(n89), .B(n66), .C(n27), .D(n92), .Y(n91) );
  OAI21X1 U111 ( .A(n93), .B(n94), .C(n26), .Y(n92) );
  NAND2X1 U112 ( .A(n95), .B(state[1]), .Y(n94) );
  NOR2X1 U113 ( .A(btn_left), .B(btn_drop), .Y(n95) );
  NAND2X1 U114 ( .A(n96), .B(n32), .Y(n93) );
  NOR2X1 U115 ( .A(gravity_tick), .B(btn_rotate), .Y(n96) );
  NOR2X1 U116 ( .A(state[0]), .B(state[2]), .Y(n42) );
  NAND3X1 U117 ( .A(state[3]), .B(state[0]), .C(n97), .Y(n66) );
  NOR2X1 U118 ( .A(state[2]), .B(state[1]), .Y(n97) );
  NOR2X1 U119 ( .A(n60), .B(n3), .Y(n89) );
  NAND3X1 U120 ( .A(\disp_cnt[1]1 ), .B(\disp_cnt[2]1 ), .C(\disp_cnt[0]1 ), 
        .Y(n60) );
  NOR2X1 U121 ( .A(n98), .B(state[0]), .Y(n69) );
  OAI21X1 U122 ( .A(n71), .B(collision_flag), .C(n77), .Y(n99) );
  AOI22X1 U123 ( .A(n22), .B(n18), .C(n36), .D(n70), .Y(n77) );
  NOR2X1 U124 ( .A(n98), .B(n29), .Y(n70) );
  NAND3X1 U125 ( .A(state[1]), .B(n26), .C(state[2]), .Y(n98) );
  NAND3X1 U126 ( .A(collision_flag), .B(n20), .C(n100), .Y(n87) );
  NOR2X1 U127 ( .A(\move_cmd[2]1 ), .B(\move_cmd[1]1 ), .Y(n100) );
  NAND3X1 U128 ( .A(n23), .B(n29), .C(state[2]), .Y(n71) );
  NAND2X1 U129 ( .A(n26), .B(n28), .Y(n83) );
  INVX1 U130 ( .A(clkb), .Y(n104) );
  INVX4 U131 ( .A(n104), .Y(n105) );
endmodule

