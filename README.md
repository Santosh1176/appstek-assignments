
# Assignments


- [x] **Use gitsign to sign git commits in local and push that records to rekor**.

- [x] **Verify gitsign signed git commits using GitHub action by verifying using rekor/cosign in GitHub action itself**

- [x] **Use cosign to sign container image in keyless mode and push to GitHub container registry using GitHub action.**

- [x] **Verify cosign signed container image using cosign within GitHub action itself**


- **CICD tasks using GitHub actions (need to repeat these in tekton.dev tool too. Tekton hub might have readily available examples)**
    - [ ] Creating an image using TektonCD and push the image to ghcr and sign the image using cosign/Tekton Chains


- **Build container image for an application using Buildah tool and push to GitHub container registry in a secure way to private GitHub container registers. This should be for signed image using cosign.**
    - [x] Created an image using Buildah CLI and pushed is securely to ghcr
    - [x] Created a GitHub Action to push an image using Buildah and then sign the image using cosign


- **Using cuelang, demonstrate how to build manifest files for an application and also how to verify manifest files with multiple varieties of conditions.**
    - [x] Validate Kubernetes manifests
    - [ ] Generate Kubernetes Manifests

- [x] **Demonstrate how to use kustomize + helm to deploy Prometheus onto k8s**

- [x] **Demonstrate how to use kustomize to deploy an application into k8s to dev environment and QA environment (dev namespace and QA namespace)**

- [x] **Demonstrate the ArgoCD setup and use ArgoCD to do application deployment where application manifest YAML files are managed by kustomize tool**


## Notes

In the above, wherever you are building container image, dockerfile should be written as multi-stage docker image build method.

Document all the above using markdown and every file should have inline code comments 


GITHUB TOKEN in New REpo No Tokenens and Keys

Push Buildah Image to Pvt Registry **Tekton**

Prometheus Repo, allways pulls charts?

Finish Learning Rancher, K3s, Talos, **CAPI** - kluctl, Karmada

Velero: Back up and DR 

*Apko* *Melange*, 
*Dive* cont image inspection

Trivy


-----------------------

Dataplane - 2 nodes
Controlplane - 2 nodes
worker - nodes
