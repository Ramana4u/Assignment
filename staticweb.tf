provider "aws"{
region = "us-east-2"
}
resource "aws_amplify_app" "simple-static-website" {
  name       = "simple-static-website"
  repository = "https://github.com/Ramana4u/simple-static-website.git"
 # access_token = "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"

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 0.1
    frontend:
      phases:
        preBuild:
          commands:
            - yarn install
        build:
          commands:
            - yarn run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }

  environment_variables = {
    ENV = "test"
  }
}
