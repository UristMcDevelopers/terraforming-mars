components {
  id: "available_action"
  component: "/available_actions_gui/available_action.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"White\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 512.0\n"
  "  y: 768.0\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
}
embedded_components {
  id: "label"
  type: "label"
  data: "size {\n"
  "  x: 128.0\n"
  "  y: 32.0\n"
  "}\n"
  "color {\n"
  "  x: 0.0\n"
  "  y: 0.0\n"
  "  z: 0.0\n"
  "}\n"
  "text: \"Label\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
  position {
    z: 0.1
  }
  scale {
    x: 4.0
    y: 4.0
    z: 4.0
  }
}
