# CICD with TektonCD

I created the `task` for cloning the GIt Repo, build the image using the Dockerdile available at the root of the repo. Configured all the `params` and `workspaces` in the tasks, and `pipeline`. referenced the workspaces from the `pipelinerun` resource by creating a `.dockerconfigjson` type `Secret`. updated the secret with Tekton specific `annotation`. 

Created the `task` with `kubectl apply -f ./task-git-clone.yaml` and  `kubectl apply -f ./task-kaniko.yaml`

Created the `pipeline` with `kubectl apply -f ./pipeline-build-push.yaml`

Created the `pipelinerun` resource with `kubectl create -f ./pelinerun.yaml`

For viewing the logs of pipelinerun resource `tkn pipelinerun logs <name of the piplinerun resource> -f` 


The `pipelinerun` is able to access the provided Workspaces. But due to some reason, I am unable to authenticate to Github. 

The Pipeline failed to complete with error:

```shell
error checking push permissions -- make sure you entered the correct tag name, and that you are authenticated correctly, and try again: checking push permission for "ghcr.io/santosh1176/bookstore/tekton-library:latest": POST https://ghcr.io/v2/santosh1176/bookstore/tekton-library/blobs/uploads/: UNAUTHORIZED: unauthenticated: User cannot be authenticated with the token provided.
```

I've provided necessary `write` permisions to the PAT while creating. The packages also are *Public* and have *write* permissions. I am able to push to the same registry using GH Actions. But there is something Tekton specific, that I am missiing in this workflow.

I've created the `Secret` using inperative command with `kubectl`. It conmtaions my GitHub username, PAT, email, server as https://ghcr.io. The following is my Secret in yaml:

```yaml
apiVersion: v1
data:
  .dockerconfigjson: eyJhdXRocyI6ey.....
kind: Secret
metadata:
  annotations:
    tekton.dev/git-0: https://gihub.com # Tekton specific Annotation
  creationTimestamp: "2023-07-21T10:16:30Z"
  name: dockerconfig-secret
  namespace: default
  resourceVersion: "867549"
  uid: 047f5352-8b32-41e2-8e8b-28e613259474
type: kubernetes.io/dockerconfigjson  # I tried with basic-auth, ssh-auth, and token type Secrets as well

```