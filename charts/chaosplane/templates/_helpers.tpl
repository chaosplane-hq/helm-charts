{{/*
Expand the name of the chart.
*/}}
{{- define "chaosplane.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "chaosplane.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chaosplane.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "chaosplane.labels" -}}
helm.sh/chart: {{ include "chaosplane.chart" . }}
{{ include "chaosplane.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "chaosplane.selectorLabels" -}}
app.kubernetes.io/name: {{ include "chaosplane.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Operator service account name.
*/}}
{{- define "chaosplane.operator.serviceAccountName" -}}
{{- if .Values.operator.serviceAccount.create }}
{{- default (printf "%s-operator" (include "chaosplane.fullname" .)) .Values.operator.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.operator.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Daemon service account name.
*/}}
{{- define "chaosplane.daemon.serviceAccountName" -}}
{{- if .Values.daemon.serviceAccount.create }}
{{- default (printf "%s-daemon" (include "chaosplane.fullname" .)) .Values.daemon.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.daemon.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Operator image.
*/}}
{{- define "chaosplane.operator.image" -}}
{{- printf "%s:%s" .Values.operator.image.repository (default .Chart.AppVersion .Values.operator.image.tag) }}
{{- end }}

{{/*
Daemon image.
*/}}
{{- define "chaosplane.daemon.image" -}}
{{- printf "%s:%s" .Values.daemon.image.repository (default .Chart.AppVersion .Values.daemon.image.tag) }}
{{- end }}
