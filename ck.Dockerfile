FROM --platform=$BUILDPLATFORM golang:1.23 AS base
WORKDIR /workspace
COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

FROM --platform=$BUILDPLATFORM base AS build
ARG TARGETOS
ARG TARGETARCH
COPY main.go main.go
COPY api/ api/
COPY controllers/ controllers/
COPY pkg/ pkg/
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} GO111MODULE=on go build -a -o manager main.go

FROM gcr.io/distroless/static:latest
WORKDIR /
COPY --from=build /workspace/manager .
ENTRYPOINT ["/manager"]
