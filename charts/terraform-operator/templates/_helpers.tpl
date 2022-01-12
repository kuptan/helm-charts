{{/*
Expand the name of the chart.
*/}}
{{- define "terraform-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "terraform-operator.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "terraform-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account
*/}}
{{- define "terraform-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
  {{ default (include "terraform-operator.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
  {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
returns image pull secrets definition if found
*/}}
{{- define "terraform-operator.imagePullSecrets" -}}
{{- if .Values.global }}
{{- if .Values.global.imagePullSecrets }}
{{- range .Values.global.imagePullSecrets }}
- name: {{ . }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
returns the docker registry for the terraform operator image
*/}}
{{- define "terraform-operator.imageRegistry" -}}
{{- if .Values.image.registry -}}
  {{ .Values.image.registry }}
{{- else -}}
  {{ default "docker.io" .Values.global.imageRegistry }}
{{- end -}}
{{- end -}}

{{/*
returns the terraform operator image
*/}}
{{- define "terraform-operator.image" -}}
  {{- printf "%s/%s:%s" (include "terraform-operator.imageRegistry" .) .Values.image.repository .Values.image.tag -}}
{{- end -}}

{{/*
returns the docker registry for the terraform runner
*/}}
{{- define "terraform-runner.imageRegistry" -}}
{{- if .Values.terraformRunner.image.registry -}}
  {{ .Values.terraformRunner.image.registry }}
{{- else -}}
  {{ default "docker.io" .Values.global.imageRegistry }}
{{- end -}}
{{- end -}}

{{/*
labels to be added to all resources
*/}}
{{- define "terraform-operator.labels" -}}
app: {{ template "terraform-operator.name" . }}
{{- if .Chart.AppVersion }}
version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
chart: {{ template "terraform-operator.chart" . }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
app.kubernetes.io/part-of: "terraform-operator"
{{- end -}}

{{/*
labels to be added to all resources
*/}}
{{- define "terraform-operator.selectorLabels" -}}
app: {{ template "terraform-operator.name" . }}
release: {{ .Release.Name }}
{{- end -}}

