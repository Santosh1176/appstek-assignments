# Use gitsign to sign git commits in local and push that records to rekor

- Install gitsign from the official docs
- configure git to add gitsign, for this example I've configured git to use gitsign for this repo only. I've also included rekor as transperancy log, google as OIDC connector:

```shell
git config --local gitsign.connectorID https://accounts.google.com
# use gitsign for this repo
git config --local commit.gpgsign true
``` 

- Confirm git is configured with gitsign:

```shell
santosh@intelops:main$ cat .git/config
[gitsign]
	connectorID = https://accounts.google.com
	rekor = https://rekor.sigstore.dev
[commit]
	gpgsign = true
[tag]
	gpgsign = true
[gpg "x509"]
	program = gitsign
[gpg]
	format = x509

```

- Now, with gitsign configured we can commit our changes with `git commit -m "message"` or optionally use `S` *capial S* and authentication page would be opened. We need to varify our identity, in my case, I've defined *google* as my connector. once identified. I can go back to my CLI, the commit will be signed using sigstore-gitsign.

## Varifying the commit signature and ensure the records exist in rekor transparancy logs

We need to provide the OIDC token provider used while signing using `--certificate-oidc-issuer=`, and our identity in `--certificate-identity=` flags repectively.

```shell
santosh@intelops:main$ gitsign verify --certificate-identity=dtshbl@gmail.com --certificate-oidc-issuer=https://accounts.google.com HEAD

# We get all the details of the signature and the log index in rekor transparancy log 
tlog index: 27770181
gitsign: Signature made using certificate ID 0xea8bd75b9341cb1cbc57af64ed2a64e76c057c53 | CN=sigstore-intermediate,O=sigstore.dev
gitsign: Good signature from [dtshbl@gmail.com](https://accounts.google.com)
Validated Git signature: true
Validated Rekor entry: true
Validated Certificate claims: true
```

from the above entry, `Validated Rekor entry: true`, we can confirm there exists an etry for this commit signature in rekore transparency logs.