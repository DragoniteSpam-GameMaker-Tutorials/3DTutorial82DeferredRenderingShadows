self.gbuff_diffuse = surface_validate(self.gbuff_diffuse, window_get_width(), window_get_height());
self.gbuff_normal = surface_validate(self.gbuff_normal, window_get_width(), window_get_height());
self.gbuff_shadows = surface_validate(self.gbuff_shadows, window_get_width(), window_get_height());

self.surf_combine = surface_validate(self.surf_combine, window_get_width(), window_get_height());

self.surf_shadowmap = surface_validate(self.surf_shadowmap, 4096, 4096, surface_r32float);