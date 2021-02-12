{{/*
Create a default fully qualified name
*/}}
{{- define "grafana-tenant.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 26 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}s

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "grafana-tenant.namespace" -}}
  {{- if .Values.grafanaNamespace -}}
    {{- .Values.grafanaNamespace -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/* Generate basic labels */}}
{{- define "grafana-tenant.labels" }}
release: {{ $.Release.Name | quote }}
heritage: {{ $.Release.Service | quote }}
{{- end }}