var right_key = keyboard_check(ord("D")) || keyboard_check(vk_right);
var left_key = keyboard_check(ord("A")) || keyboard_check(vk_left);
var jump_key = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up);
var jump_hold = keyboard_check(ord("W")) || keyboard_check(vk_space) || keyboard_check(vk_up);
is_on_ground = place_meeting(x, y + 1, obj_wall_parent) ? true : false;

// run
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

if keyboard_check_pressed(RESPAWN_BUTTON) {
	x = global.respawn_x;
	y = global.respawn_y;
	if (room != global.respawn_rm){
		room_goto(global.respawn_rm);
	}
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

if (jump_key && jump_times > 0 && is_on_ground){
	vsp = jump_speed / 2;  // init jump speed if on ground, will be acclerated
	jump_times -= 1;
	jump_duration = 0;
}else if (jump_key && extra_jump) {
	vsp = jump_speed * 3/4;
	extra_jump = false;
}else if (jump_key && jump_times > 0 && !is_on_ground){	// fixed jump height if not ground jump
	vsp = jump_speed * 3/4;
	jump_times -= 1;
}

// ground jump will be higher if hold jump longer
if (jump_hold && jump_times >= MAX_JUMP_TIMES - 1 && jump_duration <= 10){
    jump_duration += 1;
	vsp += lerp(0, jump_accleration, 1 - jump_duration / 10);
}

// h collisions
if (place_meeting(x + hsp, y, obj_wall_parent)) {
    move_contact_solid(hsp > 0 ? 0 : 180, abs(hsp));
	hsp = 0;
}else{
	x += hsp;
}

// v collisions
if (place_meeting(x, y + vsp, obj_wall_parent)) {
    move_contact_solid(vsp > 0 ? 270 : 90, abs(vsp));
    vsp = 0;
}else{
	y += vsp;
}


x = max(x, 0);
y = max(y, 0);


// level skip
if keyboard_check_pressed(vk_numpad1){
	room_goto(rm_lv1);
	x = LV1_X;
	y = LV1_Y;
}
if keyboard_check_pressed(vk_numpad2){
	room_goto(rm_lv2);
	x = LV2_X;
	y = LV2_Y;
}
if keyboard_check_pressed(vk_numpad3){
	room_goto(rm_lv3);
	x = LV3_X;
	y = LV3_Y;
}

// show_debug_message(place_meeting(x,y,obj_wall_parent));
// show_debug_message(string(x)+" "+string(y)+" "+string(room));
// show_debug_message(global.respawn_rm)