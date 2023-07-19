# Build container image for an application using Buildah tool and push to GitHub container registry in a secure way to private GitHub container registers. This should be for signed image using cosign.

## Commands:

- `buildah build --format=docker -f Dockerfile-buildah -t library-buildah:latest .`

The `--format=docker` defines the built image's manifest and metadata, the `-f Dockerfile-buildah` is the Dockerfile (multi-stage) used to build the image.

After building the image, I've pushed theimage to ghcr using following command:

`buildah push --tls-verify=true --creds santosh1176:<GITHUB_PAT> 36e16 ghcr.io/santosh1176/appstek-assignments/buildah-library:v0.0.1`

Here, buildah push cammand is used to push the image to registry, ghcr in this case. I've specified `--tls-verify=ture` allowing HTTPS connection and veryfing the certificates while pushing to ghcr. `--creds` uses my GitHub Credentials.

The image is available [here](https://github.com/users/Santosh1176/packages/container/package/appstek-assignments%2Fbuildah-library)

The image with tag `v0.0.3` and the digest was signed using cosign with the following command:

`cosign sign --key ./my-cosign-keys/cosign.key ghcr.io/santosh1176/appstek-assignments/buildah-library@sha256:03047c8555a0323760822fe3155f1684ff2d099d2f1ce4f676f4bb1db2edf207`
