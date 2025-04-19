var right_key = keyboard_check(ord("D"));
var left_key = keyboard_check(ord("A"));

hsp = (right_key - left_key) * ms;

// kill, die and respawn
if place_meeting(x, y, obj_spike) is_dead = true;

if keyboard_check_pressed(ord("R")) {
	x = global.respawn_x;
	y = global.respawn_y;
	visible = true;
	is_dead = false;
}

if is_dead {
	visible = false;
	return;
}

// set sprite
if hsp != 0 {
	face_dir = sign(hsp);
}
if hsp > 0 {
	sprite_index = sprite[FACE_RIGHT];
}else if hsp < 0 {
	sprite_index = sprite[FACE_LEFT];
}else if face_dir > 0{
	sprite_index = sprite[FACE_STILL_RIGHT];
}else{
	sprite_index = sprite[FACE_STILL_LEFT];
}

// h collisions
if (place_meeting(x + hsp, y, obj_wall_parent)) {
    move_contact_solid(hsp > 0 ? 0 : 180, abs(hsp));
    hsp = 0;
}

// jumping
if (place_meeting(x, y + 1, obj_wall_parent)){
    is_on_ground = true;
	jump_times = MAX_JUMP_TIMES;
    vsp = 0;
	jump_duration = 0;
}else{
	if (jump_times == MAX_JUMP_TIMES){
		jump_times -= 1;
	}
	is_on_ground = false;
	vsp += g;
}

if (keyboard_check_pressed(ord("W"))){
	jump_times -= 1;
	jump_duration = 0;
}

if (keyboard_check(ord("W")) && jump_times >= 0 && jump_duration < 8){
    jump_duration += 1;
	vsp = lerp(jump_speed / 2, jump_speed * 3/4, jump_duration / 8);
}

// v collisions
if (place_meeting(x, y + vsp, obj_wall_parent)) {
    move_contact_solid(vsp > 0 ? 270 : 90, abs(vsp));
    vsp = 0;
}

vsp = clamp(vsp, -5, 5);
x += hsp;
y += vsp;

x = max(x, 0);
y = max(y, 0);

