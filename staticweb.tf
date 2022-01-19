provider "aws"{
region = "us-east-2"
}
resource "aws_amplify_app" "simple-static-website" {
  name       = "simple-static-website"
  repository = "https://github.com/vigneshs123123/static-website-example.git"
  access_token = "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"

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
