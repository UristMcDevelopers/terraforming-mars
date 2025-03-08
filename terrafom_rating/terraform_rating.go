components {
  id: "terrafom_rating"
  component: "/terrafom_rating/terrafom_rating.script"
}
embedded_components {
  id: "tr_icon"
  type: "sprite"
  data: "default_animation: \"TerraformRating\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 512.0\n"
  "  y: 512.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/global/global.atlas\"\n"
  "}\n"
  ""
  position {
    x: 256.0
  }
}
embedded_components {
  id: "box_icon"
  type: "sprite"
  data: "default_animation: \"White\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 256.0\n"
  "  y: 512.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/global/global.atlas\"\n"
  "}\n"
  ""
  position {
    x: 896.0
  }
}
embedded_components {
  id: "box_label"
  type: "label"
  data: "size {\n"
  "  x: 32.0\n"
  "  y: 64.0\n"
  "}\n"
  "color {\n"
  "  x: 0.0\n"
  "  y: 0.0\n"
  "  z: 0.0\n"
  "}\n"
  "text: \"20\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    x: 896.0
    z: 0.1
  }
  scale {
    x: 8.0
    y: 8.0
  }
}
embedded_components {
  id: "tr_player_icon"
  type: "sprite"
  data: "default_animation: \"White\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 256.0\n"
  "  y: 512.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/global/global.atlas\"\n"
  "}\n"
  ""
  position {
    x: 640.0
  }
}
embedded_components {
  id: "tr_player_id"
  type: "label"
  data: "size {\n"
  "  x: 32.0\n"
  "  y: 64.0\n"
  "}\n"
  "color {\n"
  "  x: 0.0\n"
  "  y: 0.0\n"
  "  z: 0.0\n"
  "}\n"
  "text: \"P1\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    x: 640.0
    z: 0.1
  }
  scale {
    x: 8.0
    y: 8.0
  }
}
