package kubernetes

// I Deployment and Service and a #Schema which uses a "|", a `disjuction operator like an "OR". 

// Each reource has a `apiVersion`, Kind`, metadata, and spec structs. The `...` spread operator like operator,
// allows more fields to be allowed.

// Remove Boiler plate fields into reusible definitions:

_labels: [string]: string

_metadata: {
	name:       string
	namespace?: string
	labels:     _labels
	annotations?: [string]: string}

//Referenced the pedefined definitions in the appropriate fields, `metadata` and `labels` and `selector` values.

#Schema: #Deployment | #Service
#Deployment: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata:   _metadata
	spec: {
		strategy: {...}
		template: {...}
		replicas: int
		selector: {
			matchLabels: _labels
		}
	}
	...  // More fields are allowed
}

#Service: {
	apiVersion: "v1"
	kind:       "Service"
	metadata:   _metadata
	spec: {
		selector: _labels
		type:     string
		ports: [...{...}]  // This can be further spread according to the `containerPort` field in the pod container secpec.
	}
	...
}

// Now we can validate the the deploy.yaml against our Schema in deploy-schema.yaml using following command:

//cue vet deploy.yaml deploy-shcema.yaml -d "#Schema"

//Here the `-d` flag allows Cue to parse through the yaml document that has more the one resources (Deployment and Service)
