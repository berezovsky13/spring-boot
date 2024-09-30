{{/*
    Generate common labels for Kubernetes resources.
    */}}
    {{- define "helm-chart.labels" -}}
    app.kubernetes.io/name: {{ include "helm-chart.name" . }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    app.kubernetes.io/version: {{ .Chart.AppVersion }}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    {{- end -}}
    
    {{/*
    Create a default fully qualified name.
    */}}
    {{- define "helm-chart.fullname" -}}
    {{- $name := default .Chart.Name .Values.nameOverride -}}  # Default to the chart name
    {{- $fullnameOverride := default "" .Values.fullnameOverride -}}  # Use an empty string if fullnameOverride is not set
    {{- if $fullnameOverride }}
      {{- $fullnameOverride | trunc 63 | trimSuffix "-" -}}  # Use fullnameOverride if it's provided
    {{- else }}
      {{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}  # Combine chart name and release name if no fullnameOverride
    {{- end -}}
    {{- end -}}
    
    {{/*
    Create a default name for the application.
    */}}
    {{- define "helm-chart.name" -}}
    {{- if .Values.nameOverride }}
      {{- .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else }}
      {{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
    {{- end -}}
    
    {{/*
    Create a name for the ServiceAccount.
    */}}
    {{- define "helm-chart.serviceAccountName" -}}
    {{- if .Values.serviceAccount.name }}
      {{- .Values.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
    {{- else }}
      {{- printf "%s-%s" (include "helm-chart.fullname" .) "sa" | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
    {{- end -}}