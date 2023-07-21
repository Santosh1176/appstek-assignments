# Verify gitsign signed git commits using GitHub action by verifying using rekor/cosign in GitHub action itself

As keyless varification requires `--certificate-identity=` to varify the identity expected in the Fulcio certificate, and `--certificate-oidc-issuer` the value of the OIDC token issuer during signingthe commit. As the commit may come from different users using their email and may use any one among three currently suppirted IODC providers. It becomes complex to varify the signatures in a automated workflow like GitHub Action. To overcome this, Sigstore project proved a `REGEX` flags for the above flags. `--certificate-identity-regexp`, and `--certificate-oidc-issuer-regexp`.

I've used these Regex flags to varifythe gitsigned commits in the `Verify commit` step of the Action at linbe 43.
