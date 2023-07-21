# Use cosign to sign container image in keyless mode and push to GitHub container registry using GitHub action.

Inorder to enable to generate an OIDC token to get the required keys for signingthe image. A specific permission of `id-token` for our PAT is required to saet to `write-all`. This allows to request an OpenID Connect JWT Token and use it to get a certificate from Fulcio.

To sign the built image digest, I've used the `--certificate-oidc-issuer-regexp`, and `--certificate-identity-regexp` tosign the image in Keyless mode.  