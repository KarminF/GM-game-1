draw_self();
var jumps_remain = jump_times + extra_jump + vine_jump_times;
var text_x = -15;
if sprite_index == spr_player_l || sprite_index == spr_player_still_l {
	text_x = 5;
}
draw_text(x + text_x, y - 30, string(jumps_remain));