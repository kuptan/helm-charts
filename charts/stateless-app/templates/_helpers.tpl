{{/* Helm job env vars */}}
{{- define "app.env" -}}
  {{ toYaml .Values.app.env | indent 6 }}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "app.name" -}}
{{- default .Release.Name -}}
{{- end -}}
