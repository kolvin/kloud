include "root" {
  path = find_in_parent_folders("common.hcl")
}

include "component" {
  path = find_in_parent_folders("component.hcl")
}
