hsp = 0;
vsp = 0;
ms = 2;

face_dir = 1;	// for the facing direction after stopping moving

is_dead = false;

g = 0.3;
is_jumping = false;
is_on_ground = true;
jump_speed = -4;
jump_times = MAX_JUMP_TIMES;
jump_duration = 0;

sprite[FACE_RIGHT] = spr_player_r;
sprite[FACE_LEFT] = spr_player_l;
sprite[FACE_STILL_RIGHT] = spr_player_still_r;
sprite[FACE_STILL_LEFT] = spr_player_still_l;
