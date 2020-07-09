{{/* Helm job env vars */}}
{{- define "app.env" -}}
  {{ toYaml .Values.app.env | indent 6 }}
{{- end -}}
