components {
  id: "skip_button"
  component: "/skip_button/skip_button.script"
}
embedded_components {
  id: "next_round"
  type: "sprite"
  data: "default_animation: \"Next_round2\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
  position {
    x: 312.0
    y: 188.5
  }
}
embedded_components {
  id: "skip_turn"
  type: "sprite"
  data: "default_animation: \"Skip_turn\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/ui/ui.atlas\"\n"
  "}\n"
  ""
  position {
    x: 312.0
    y: 188.5
  }
}
