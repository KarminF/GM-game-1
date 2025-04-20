hsp = 0;
vsp = 0;
ms = 2;
acceleration = 0.25;
g = GRAVITY;
jump_speed = -4;
jump_accleration = -0.4;

face_dir = 1;	// for the facing direction after stopping moving

is_dead = false;

is_jumping = false;
is_on_ground = true;
is_on_vine = false;
vine_jump_times = MAX_JUMP_TIMES;
jump_times = MAX_JUMP_TIMES;
jump_duration = 0;
extra_jump = false;
a_speed = 0;

sprite[FACE_RIGHT] = spr_player_r;
sprite[FACE_LEFT] = spr_player_l;
sprite[FACE_STILL_RIGHT] = spr_player_still_r;
sprite[FACE_STILL_LEFT] = spr_player_still_l;

show_debug_message(3_3)