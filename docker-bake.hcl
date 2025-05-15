group "default" {
    targets = ["build"]
}

variable "REGISTRY_ID" {
    default = "475844994616"
}

variable "REGISTRY_REGION" {
    default = "us-west-2"
}

variable "IMAGE_PATH" {
    default = "crossnokaye/secret-syncer"
}

variable "IMAGE_TAG" {
    default = "latest"
}

variable "tag" {
    default = "${REGISTRY_ID}.dkr.ecr.${REGISTRY_REGION}.amazonaws.com/${IMAGE_PATH}:${IMAGE_TAG}"
}

target "build" {
    context = "."
    dockerfile = "ck.Dockerfile"
    platforms = ["linux/amd64", "linux/arm64"]
    tags = [tag]
    load = true
    output = [
        "type=image,name=${tag}",
        "type=docker,name=${tag}"
    ]
}