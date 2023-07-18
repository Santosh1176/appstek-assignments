# Tasks to do by Friday :-

1. **Use gitsign to sign git commits in local and push that records to rekor**

2. **Verify gitsign signed git commits using GitHub action by verifying using rekor/cosign in GitHub action itself**

3. **Use cosign to sign container image in keyless mode and push to GitHub container registry using GitHub action.**

4. **Verify cosign signed container image using cosign within GitHub action itself**


5. **CICD tasks using GitHub actions (need to repeat these in tekton.dev tool too. Tekton hub might have readily available examples)**

6. **Build container image for an application using Buildah tool and push to GitHub container registry in a secure way to private GitHub container registers. This should be for signed image using cosign.**


7. **Using cuelang, demonstrate how to build manifest files for an application and also how to verify manifest files with multiple varieties of conditions.**

8. **Demonstrate how to use kustomize + helm to deploy Prometheus onto k8s**

9. **Demonstrate how to use kustomize to deploy an application into k8s to dev environment and QA environment (dev namespace and QA namespace)**

10. **Demonstrate the ArgoCD setup and use ArgoCD to do application deployment where application manifest YAML files are managed by kustomize tool**

11. **In the above, wherever you are building container image, dockerfile should be written as multi-stage docker image build method**

- ## Document all the above using markdown and every file should have inline code comments 