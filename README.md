# Learning Terraform

A hands-on lesson for learning Terraform basics using only local resources.

## Prerequisites

Install Terraform via Homebrew:

```bash
brew install terraform
```

## Lesson 1: Hello, Terraform!

In this first step you'll create a single file on disk using Terraform.

### Step 1 — Write the config

Create a file called `main.tf`:

```hcl
resource "local_file" "hello" {
  filename = "${path.module}/hello.txt"
  content  = "Hello, Terraform!"
}
```

This declares a single **resource**: a local file with a specific filename and content. You describe *what* you want, and Terraform figures out how to make it happen.

### Step 2 — Initialize

```bash
terraform init
```

This downloads the **provider** (in this case `local`) that knows how to manage local files.

### Step 3 — Preview

```bash
terraform plan
```

Terraform shows you what it *will* do without actually doing it. You should see it plans to create one file.

### Step 4 — Apply

```bash
terraform apply
```

Type `yes` when prompted. Terraform creates `hello.txt` in your project directory.

### Step 5 — Experiment

Change the `content` in `main.tf` and run `terraform apply` again. Terraform detects the difference and updates the file. 

Check the content of the file:


```bash
cat hello.txt
```

What happens if you change the txt file your self and save and then run `terraform apply`?

To delete the resource/file run `terraform destroy`.

## Lesson 2: Variables and Outputs

Now you'll make the config dynamic by introducing **variables** and **outputs**, and learn how to organize your code into multiple files.

### Step 1 — Define a variable

Create a file called `variables.tf`:

```hcl
variable "name" {
  default = "Johannes"
}
```

This declares an input variable with a default value. You can override it at apply time.

### Step 2 — Use the variable in a resource

Add a second resource to `main.tf`:

```hcl
resource "local_file" "greeting_you" {
  filename = "${path.module}/greeting.txt"
  content  = "Hello, ${var.name}!"
}
```

The `${var.name}` syntax references the variable you just defined.

### Step 3 — Add an output

Create a file called `outputs.tf`:

```hcl
output "greeting" {
  value = "File created for ${var.name}"
}
```

Outputs are printed after `apply` and are useful for surfacing information.

### Step 4 — Apply

```bash
terraform apply
```

This creates `greeting.txt` with the content "Hello, Johannes!" and prints the output.

### Step 5 — Override the variable

```bash
terraform apply -var="name=World"
```

Now the file says "Hello, World!" instead. Variables make your config reusable.

## Lesson 3: Creating Folders

Terraform can create nested directory structures automatically. Just reference the full path in `filename` and the `local_file` resource creates any missing directories for you.

### Step 1 — Add a nested file resource

Add to `main.tf`:

```hcl
resource "local_file" "nested_folders" {
  filename = "${path.module}/parent/child/nested.txt"
  content  = "I'm nested!"
}
```

### Step 2 — Apply

```bash
terraform apply
```

This creates the `parent/child/` directory structure and the `nested.txt` file inside it. Running `terraform destroy` will clean up both the file and the directories.

## File structure

Terraform loads all `.tf` files in a directory automatically. The conventional layout is:

| File | Purpose |
|---|---|
| `main.tf` | Resources |
| `variables.tf` | Input variables |
| `outputs.tf` | Outputs |

## Cleanup

```bash
terraform destroy
```

This removes all resources Terraform created.
