var right_key = keyboard_check(ord("D"));
var left_key = keyboard_check(ord("A"));

a_speed = (right_key - left_key) * acceleration;
if ((sign(hsp) != sign(a_speed)) && (hsp != 0)){
	hsp = 0;
}else{
	hsp += a_speed;
}
hsp = clamp(hsp, -ms, ms);
if (!right_key && !left_key){
	hsp = 0;
}

// kill, die and respawn
if place_meeting(x, y, obj_kill) is_dead = true;

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

// jumping
is_on_ground = place_meeting(x, y + 1, obj_wall_parent) ? true : false;
if (is_on_ground){
	extra_jump = false;
	jump_times = MAX_JUMP_TIMES;
    vsp = 0;
	jump_duration = 0;
}else{
	if (jump_times == MAX_JUMP_TIMES){	// if didn't jump but walked into air, jump_times -= 1
		jump_times -= 1;
	}
	vsp += g;
}

if (keyboard_check_pressed(ord("W")) && jump_times > 0){
	jump_times -= 1;
	jump_duration = 0;
	if (!is_on_ground){		// fixed jump height if not ground jump
		vsp = jump_speed * 3/4;
	}
}else if (keyboard_check_pressed(ord("W")) && extra_jump) {
	vsp = jump_speed * 3/4;
	extra_jump = false;
}

// ground jump will be higher if hold jump longer
if (keyboard_check(ord("W")) && jump_times >= MAX_JUMP_TIMES - 1 && jump_duration < 8){
    jump_duration += 1;
	vsp = lerp(jump_speed / 2, jump_speed * 3/4, 1 - jump_duration / 8);
}

// h collisions
if (place_meeting(x + hsp, y, obj_wall_parent)) {
    move_contact_solid(hsp > 0 ? 0 : 180, abs(hsp));
    hsp = 0;
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

