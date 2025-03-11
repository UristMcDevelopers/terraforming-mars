components {
  id: "hex_grid_ui"
  component: "/hex_grid/hex_grid_ui.script"
}
components {
  id: "hex_grid_controller"
  component: "/hex_grid/hex_grid_controller.script"
}
embedded_components {
  id: "hex_factory"
  type: "factory"
  data: "prototype: \"/hex_grid/single_hex.go\"\n"
  ""
}
