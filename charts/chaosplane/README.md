# ChaosPlane Helm Chart

Helm chart for deploying ChaosPlane chaos engineering platform on Kubernetes.

## Components

- Operator: Reconciles ChaosExperiment and BlastRadiusPolicy custom resources
- Daemon: DaemonSet running on all worker nodes for executing chaos actions

## Install

```bash
helm install chaosplane ./charts/chaosplane
```

## Configuration

See [values.yaml](values.yaml) for configurable parameters.

| Parameter | Default | Description |
|-----------|---------|-------------|
| `operator.replicas` | `1` | Operator replica count |
| `operator.image.repository` | `ghcr.io/chaosplane-hq/chaosplane-operator` | Operator image |
| `operator.image.tag` | `appVersion` | Operator image tag |
| `daemon.image.repository` | `ghcr.io/chaosplane-hq/chaosplane-daemon` | Daemon image |
| `daemon.image.tag` | `appVersion` | Daemon image tag |

## CRDs

CRDs are installed automatically from the `crds/` directory:

- `ChaosExperiment` — defines a chaos experiment targeting Kubernetes resources
- `BlastRadiusPolicy` — defines safety guardrails for experiments
