if (!visible) {
    respawn_timer += delta_time;
    if (respawn_timer >= respawn_time) {
        visible = true;
        respawn_timer = 0;
    }
}