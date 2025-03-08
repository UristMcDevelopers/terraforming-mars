components {
  id: "terraform_rating_bar"
  component: "/terrafom_rating/terraform_rating_bar.script"
}
embedded_components {
  id: "rating_factory"
  type: "factory"
  data: "prototype: \"/terrafom_rating/terraform_rating.go\"\n"
  ""
}
