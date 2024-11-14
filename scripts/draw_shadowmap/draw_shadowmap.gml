function draw_shadowmap(px, py, pz) {
    var light_x = 2_000;
    var light_y = 2_000;
    var light_z = 2_000;
    self.light_view_mat = matrix_build_lookat(px + light_x, py + light_y, pz + light_z, px, py, pz, 0, 0, 1);
    var light_w = 600;
    var light_h = 600;
    self.light_proj_mat = matrix_build_projection_ortho(-light_w, -light_h, 1, 4_000);
    
    surface_set_target(self.surf_shadowmap);
    draw_clear(c_black);
    
    var cam = camera_get_active();
    camera_set_view_mat(cam, light_view_mat);
    camera_set_proj_mat(cam, light_proj_mat);
    camera_apply(cam);
    
    shader_set(shd_shadowmap);

    gpu_set_cullmode(cull_noculling);
    gpu_set_zwriteenable(true);
    gpu_set_ztestenable(true);
    
    vertex_submit(self.vb_floor, pr_trianglelist, -1);

    var duck_angle = ((self.player.direction - self.player.face_direction) + 360) % 360;
    if (duck_angle >= 320 || duck_angle < 40) {
        var zrot = 90;
        var spr = duck_front;
    } else if (duck_angle >= 220) {
        var zrot = 0;
        var spr = duck_right;
    } else if (duck_angle >= 140) {
        var zrot = 90;
        var spr = duck_back;
    } else if (duck_angle >= 40) {
        var zrot = 180;
        var spr = duck_left;
    }

    matrix_set(matrix_world, matrix_build(self.player.x, self.player.y, self.player.z, 0, 0, self.player.face_direction + zrot, 1, 1, 1));
    vertex_submit(self.vb_player, pr_trianglelist, sprite_get_texture(spr, floor(self.player.frame)));

    for (var i = 0, n = array_length(self.world_objects); i < n; i++) {
        var object = self.world_objects[i];
        matrix_set(matrix_world, object.transform);
        vertex_submit(object.model, pr_trianglelist, -1);
    }

    var terrain_tex = sprite_get_texture(spr_terrain, 0);

    for (var i = 0,n = array_length(self.terrain_objects); i < n; i++) {
        var object = self.terrain_objects[i];
        matrix_set(matrix_world, object.transform);
        vertex_submit(object.model, pr_trianglelist, terrain_tex);
    }

    gpu_set_cullmode(cull_noculling);
    gpu_set_zwriteenable(false);
    gpu_set_ztestenable(false);
    shader_reset();
    surface_reset_target();
    matrix_set(matrix_world, matrix_build_identity());
}