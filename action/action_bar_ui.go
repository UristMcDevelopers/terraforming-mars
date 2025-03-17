components {
  id: "ui_action"
  component: "/action/action_bar_ui.script"
}
embedded_components {
  id: "action1_spended_icon"
  type: "sprite"
  data: "default_animation: \"Spended_action\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
  position {
    x: -256.0
  }
}
embedded_components {
  id: "action1_not_spended_icon"
  type: "sprite"
  data: "default_animation: \"Not_spended_action\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
  position {
    x: -256.0
  }
}
embedded_components {
  id: "action2_not_spended_icon"
  type: "sprite"
  data: "default_animation: \"Not_spended_action\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 512.0\n"
  "  y: 512.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
  position {
    x: 256.0
  }
}
embedded_components {
  id: "action2_spended_icon"
  type: "sprite"
  data: "default_animation: \"Spended_action\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 512.0\n"
  "  y: 512.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
  position {
    x: 256.0
  }
}
