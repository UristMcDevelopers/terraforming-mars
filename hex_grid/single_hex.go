components {
  id: "single_hex"
  component: "/hex_grid/single_hex.script"
}
embedded_components {
  id: "hex_sprite"
  type: "sprite"
  data: "default_animation: \"Empty\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/tiles/tiles.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "marker_sprite"
  type: "sprite"
  data: "default_animation: \"Player_marker\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 75.0\n"
  "  y: 75.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/tiles/tiles.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.1
  }
}
embedded_components {
  id: "recource_sprite1"
  type: "sprite"
  data: "default_animation: \"Plant\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 75.0\n"
  "  y: 75.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/recources/player/recources.atlas\"\n"
  "}\n"
  ""
  position {
    x: -9.0
    y: 175.0
    z: -0.1
  }
}
embedded_components {
  id: "recource_sprite2"
  type: "sprite"
  data: "default_animation: \"Draw\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 75.0\n"
  "  y: 75.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/recources/player/recources.atlas\"\n"
  "}\n"
  ""
  position {
    x: -111.0
    y: 115.0
    z: -0.1
  }
}
