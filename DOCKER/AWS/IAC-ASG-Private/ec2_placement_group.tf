#AS Placement Group

resource "aws_placement_group" "managers" {
  name      = "managers"
  strategy  = "cluster"
}

resource "aws_placement_group" "workers" {
  name      = "workers"
  strategy  = "cluster"
}

resource "aws_placement_group" "dtr_workers" {
  name      = "dtr_workers"
  strategy  = "cluster"
}

resource "aws_placement_group" "windows_workers" {
  name      = "windows_workers"
  strategy  = "cluster"
}
