workflow "New workflow" {
  on = "push"
  resolves = ["hugo"]
}

action "hugo" {
  uses = "hugo"
  args = "--baseURL https://arda.karaduman.web.tr/"
}
