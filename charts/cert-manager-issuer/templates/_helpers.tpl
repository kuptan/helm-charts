{{/* selfSigned defaults */}}
{{- define "issuer.selfSigned" }}
  {{- if hasKey .Values.selfSigned "crlDistributionPoints" }}
  selfSigned: 
  {{- with .Values.selfSigned }}
    {{- toYaml . | nindent 4  }}
  {{- end }}
  {{- else }}
  selfSigned: {{- toYaml .Values.selfSigned }}
  {{- end }}
{{- end }}