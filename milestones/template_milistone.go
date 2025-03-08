components {
  id: "template_milestone"
  component: "/milestones/template_milestone.script"
}
embedded_components {
  id: "image"
  type: "sprite"
  data: "default_animation: \"Banker\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 512.0\n"
  "  y: 512.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/milestones_awards/milistones_awards.atlas\"\n"
  "}\n"
  ""
  position {
    x: 256.0
    y: 384.0
  }
}
embedded_components {
  id: "white_box"
  type: "sprite"
  data: "default_animation: \"White\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 256.0\n"
  "  y: 256.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/milestones_awards/milistones_awards.atlas\"\n"
  "}\n"
  ""
  position {
    x: 256.0
    y: 384.0
    z: 0.1
  }
}
embedded_components {
  id: "player_id"
  type: "label"
  data: "size {\n"
  "  x: 64.0\n"
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
    x: 256.0
    y: 384.0
    z: 0.2
  }
  scale {
    x: 8.0
    y: 8.0
  }
}
embedded_components {
  id: "name_box"
  type: "sprite"
  data: "default_animation: \"White\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 512.0\n"
  "  y: 128.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/milestones_awards/milistones_awards.atlas\"\n"
  "}\n"
  ""
  position {
    x: 256.0
    y: 64.0
    z: 0.1
  }
}
embedded_components {
  id: "name"
  type: "label"
  data: "size {\n"
  "  x: 128.0\n"
  "  y: 64.0\n"
  "}\n"
  "color {\n"
  "  x: 0.0\n"
  "  y: 0.0\n"
  "  z: 0.0\n"
  "}\n"
  "text: \"Terraformer\\n"
  "\"\n"
  "  \"\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    x: 256.0
    y: 64.0
    z: 0.2
  }
  scale {
    x: 5.5
    y: 5.5
  }
}
