components {
  id: "available_actions_gui"
  component: "/available_actions_gui/available_actions_gui.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"White\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 128.0\n"
  "  y: 128.0\n"
  "  z: -0.1\n"
  "}\n"
  "size_mode: SIZE_MODE_MANUAL\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
  position {
    z: -0.1
  }
}
embedded_components {
  id: "label"
  type: "label"
  data: "size {\n"
  "  x: 128.0\n"
  "  y: 128.0\n"
  "}\n"
  "color {\n"
  "  x: 0.0\n"
  "  y: 0.0\n"
  "  z: 0.0\n"
  "}\n"
  "text: \"Available\\n"
  "\"\n"
  "  \"actions\"\n"
  "font: \"/builtins/fonts/default.font\"\n"
  "material: \"/builtins/fonts/label-df.material\"\n"
  ""
}
embedded_components {
  id: "factory"
  type: "factory"
  data: "prototype: \"/available_actions_gui/available_action.go\"\n"
  ""
}
