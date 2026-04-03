resource "local_file" "hello" {
  filename = "${path.module}/hello.txt"
  content  = "Hello, Terraform!"
}

resource "local_file" "greeting_you" {
  filename = "${path.module}/greeting.txt"
  content  = "Hello, ${var.name}!"
}

resource "local_file" "nested_folders" {
  filename = "${path.module}/parent/child/nested.txt"
  content  = "I'm nested!"
}
