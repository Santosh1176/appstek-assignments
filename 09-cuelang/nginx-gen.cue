// a variable defining labels. the `_` here will be ignored when evaluating the
// cue schema. 
_labels: {
	app: "nginx"
	env: "test"
}

container: [ID=string]: {
	name:  (ID)
	image: (ID)
	securityContext: {
		allowPrivilegeEscalation: bool | *false
		privileged:               bool | *false
		sreadOnlyRootFilesystem:  bool | *true
	}
}

apiVersion: "apps/v1"
kind:       "Deployment"
metadata: {
	//referencing the `_labels` variable
	labels: _labels
	name:   "cue-deploy"
}
spec: {
	replicas: 1
	selector: matchLabels: _labels

	strategy: {}
	template: {
		metadata: labels: _labels

		spec: containers: 
		
	}
}
