#  ArgoCD setup and use ArgoCD to do application deployment where application manifest YAML files are managed by kustomize tool

- Install Argocd on the cluster, CLI on local machine. Login to the UI and CLI using the initial password provided in the secret `argocd-initial-admin-secret` in argocd namespace.

- To install an application using Kustomization, we need to bundle the Kustoimize overlays as oci artifact and push it to a oci compliant registry, ghcr in our case.
- Building of the kustomize overlays as oci artifact and pushing it to ghcr is achived by GitHub action in [this](https://github.com/Santosh1176/bookstore-api.git) application repo. I've used `flux` cli to build and push an artifact to the registry. the commands for the same are in the GH Action on [here](https://github.com/Santosh1176/bookstore-api/blob/bf074cd650687bc8ea43e2e1b6b0522ca3710e24/.github/workflows/image-push-ghcr.yaml#L73)

- Now we can reference this kustomize artifact in our argocd application creation workflow.

## Following command to create an application in Argocd using Kustomize overlays as OCI artifact

`argocd app create bookstore-test --repo https://github.com/Santosh1176/bookstore-api.git --path kustomize --dest-server https://kubernetes.default.svc --kustomize-image ghcr.io/santosh1176/bookstore:latest`

- Argocd app create command overview
    - `bookstore-test` is the application name in ArgoCD
    - `--repo` flag needs the the repository link (GitHub in our case) for the manifests
    - `--path` flag is provided the relative path where the Kustomize overlays are housed in the repo's directory hierarchy.
    - `dest-server` is the url of our local Kubernetes cluster
    - `kustomize-image` is the url of the artifact in oci registry. The artifact is available in ghcr in this repo as package as well.
    - `--sync-policy` We can set the sync policy as `automated` for automatic sync whenm there's a update in the Application repository.  

when the above command is run, an application is created in ArgoCD:

```
santosh@intelops:main$ argocd app create bookstore-test --repo https://github.com/Santosh1176/bookstore-api.git --path kustomize --dest-server https://kubernetes.default.svc --kustomize-image ghcr.io/santosh1176/bookstore:latest
application 'bookstore-test' created
```
As I've not set the automated `sync-policy`. I need to sync the application manually by:
```shell
santosh@intelops:main$ argocd app sync bookstore-test
TIMESTAMP                  GROUP        KIND              NAMESPACE                    NAME    STATUS    HEALTH        HOOK  MESSAGE
2023-07-21T00:48:56+05:30            Service             frontend-api          frontend-svc  OutOfSync  Missing              
2023-07-21T00:48:56+05:30   apps  Deployment             frontend-api    bookstore-frontend  OutOfSync  Missing  
<redacted>
.
.
GROUP  KIND                   NAMESPACE     NAME                 STATUS  HEALTH       HOOK  MESSAGE
       Secret                 frontend-api  frontend-secret      Synced                     secret/frontend-secret created
       Secret                 database      postgres-secret      Synced                     secret/postgres-secret created
       ConfigMap              frontend-api  frontend-cm          Synced                     configmap/frontend-cm created
       ConfigMap              database      postgres-config      Synced                     configmap/postgres-config created
       PersistentVolume                     bookstore-pv-volume  Synced                     persistentvolume/bookstore-pv-volume created
       PersistentVolumeClaim  database      bookstore-pv-claim   Synced  Healthy            persistentvolumeclaim/bookstore-pv-claim created
       Service                database      postgres             Synced  Healthy            service/postgres created
       Service                frontend-api  frontend-svc         Synced  Healthy            service/frontend-svc created
apps   Deployment             frontend-api  bookstore-frontend   Synced  Progressing        deployment.apps/bookstore-frontend created
apps   StatefulSet            database      postgres             Synced  Progressing        statefulset.apps/postgres created
santosh@intelops:main$
```
The app start to sync.

We can `get` the application to view more info about the created appication:

```shell
santosh@intelops:main$ argocd app get bookstore-test
Name:               argocd/bookstore-test
Project:            default
Server:             https://kubernetes.default.svc
Namespace:          
URL:                https://172.18.0.2:30080/applications/bookstore-test
Repo:               https://github.com/Santosh1176/bookstore-api.git
Target:             
Path:               kustomize
SyncWindow:         Sync Allowed
Sync Policy:        <none>
Sync Status:        Synced to  (bf074cd)
Health Status:      Healthy

GROUP  KIND                   NAMESPACE     NAME                 STATUS  HEALTH   HOOK  MESSAGE
       Secret                 frontend-api  frontend-secret      Synced                 secret/frontend-secret created
       Secret                 database      postgres-secret      Synced                 secret/postgres-secret created
       ConfigMap              frontend-api  frontend-cm          Synced                 configmap/frontend-cm created
       ConfigMap              database      postgres-config      Synced                 configmap/postgres-config created
       PersistentVolume                     bookstore-pv-volume  Synced                 persistentvolume/bookstore-pv-volume created
       PersistentVolumeClaim  database      bookstore-pv-claim   Synced  Healthy        persistentvolumeclaim/bookstore-pv-claim created
       Service                database      postgres             Synced  Healthy        service/postgres created
       Service                frontend-api  frontend-svc         Synced  Healthy        service/frontend-svc created
apps   Deployment             frontend-api  bookstore-frontend   Synced  Healthy        deployment.apps/bookstore-frontend created
apps   StatefulSet            database      postgres             Synced  Healthy        statefulset.apps/postgres created
```

## Inspecting the Application in the UI

The initail screen of the Argocd UI shows the app is synced and in a Healthy state:

![bookstore-app-running](https://github.com/Santosh1176/bookstore-api/assets/91916466/27151a31-fe11-4467-8ae8-05a4fc265552)

Now, if we expand the tab for detailed view of the application, we can see the state of each Kubernetes resource from the application:

![bookstore-sync-healthy](https://github.com/Santosh1176/bookstore-api/assets/91916466/a6ea7f6c-54b5-4a30-b07b-c8af36514fb0)


The bookstore application is served through the NodePort Service. We can access it using the NodeIP and high port 31000, and the Revision is the short CommitSHA of HEAD:

![bookstore-home-screen](https://github.com/Santosh1176/bookstore-api/assets/91916466/587a3cf6-8ab0-4981-826f-6fa7091ee220)