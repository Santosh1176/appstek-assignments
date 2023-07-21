# Validate Kubernetes Manifests


I have Deployment and Service definition in `deploy,yaml` and have defined a #Schema in `deploy-schema.cue` which uses a "|", a `disjuction operator like an "OR" with Deployment and Service resources. 

Each reource has a `apiVersion`, Kind`, metadata, and spec structs. The `...` spread operator like operator, allows more fields to be allowed, just like Javascript Spred operator. If we add more values in Deployment or Service Spec section, The validation will pass.

To remove some of the repetitive structs from both of the resources like  metadata and labels. I have creaed a definition named `_metedata` and `_labels` at the top-level, and have rerefenced them accordingly. 

As the `metadata` struct is not opento more fields in the schema file. we cannot add more fields to the `metadata` section of the deploy.yaml file. I have added `managedFields` field in the `metdata` and the `cue vet` error's out at this.

To validate the the `deploy.yaml` against our Schema in `deploy-schema.yaml` the following command can be applied
`cue vet deploy.yaml deploy-shcema.yaml -d "#Schema"`

Here the `-d` flag allows Cue to parse through the yaml document that has more the one resources (Deployment and Service) and `#Schema` for to point which definition in the file to validate.
