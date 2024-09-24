{{/*
    Expand the name of the chart.
    */}}
    {{- define "mychart.name" -}}
    {{ .Chart.Name }}
    {{- end }}
    
    {{/*
    Create a default fully qualified app name.
    */}}
    {{- define "mychart.fullname" -}}
    {{ include "mychart.name" . }}-{{ .Release.Name }}
    {{- end }}
    
    {{/*
    ServiceAccount name generator.
    */}}
    {{- define "mychart.serviceAccountName" -}}
    {{- if .Values.serviceAccount.name }}
    {{ .Values.serviceAccount.name }}
    {{- else }}
    {{ include "mychart.fullname" . }}
    {{- end }}
    {{- end }}
    