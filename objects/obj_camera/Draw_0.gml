draw_shadowmap(self.player.x, self.player.y, self.player.z);

surface_set_target(self.gbuff_diffuse);
surface_set_target_ext(1, self.gbuff_normal);
surface_set_target_ext(2, self.gbuff_shadows);
shader_set(shd_deferred_gbuff);

draw_clear(c_black);

var samp_shadowmap = shader_get_sampler_index(shd_deferred_gbuff, "samp_shadowmap");
texture_set_stage(samp_shadowmap, surface_get_texture(self.surf_shadowmap));
var u_light_view_mat = shader_get_uniform(shd_deferred_gbuff, "u_light_view_mat");
var u_light_proj_mat = shader_get_uniform(shd_deferred_gbuff, "u_light_proj_mat");
shader_set_uniform_f_array(u_light_view_mat, self.light_view_mat);
shader_set_uniform_f_array(u_light_proj_mat, self.light_proj_mat);



var xto = self.player.x;
var yto = self.player.y;
var zto = self.player.z + 16;
var xfrom = xto + self.player.distance * dcos(self.player.direction) * dcos(self.player.pitch);
var yfrom = yto - self.player.distance * dsin(self.player.direction) * dcos(self.player.pitch);
var zfrom = zto - self.player.distance * dsin(self.player.pitch);

self.mat_view = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);

draw_3d_world();