{{/*
Expand the name of the application.
*/}}
{{- define "helper.name" -}}
{{- default .Release.Name $.Values.base.appName | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "helper.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- include "helper.name" . }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "helper.labels" -}}
helm.sh/chart: {{ include "helper.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with $.Values.base.labels.all }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "helper.selectorLabels" -}}
app.kubernetes.io/name: {{ include "helper.fullname" . }}
{{- end }}

{{- define "helper.annotations" -}}
{{- with $.Values.base.annotations.all -}}
{{ toYaml . }}
{{- end }}
{{- end }}


{{- define "helper.fullname" -}}
{{- if .fullnameOverride }}
{{- .fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{ printf "%s-%s" (include "helper.name" $) ($name := .name | required ".name or .fullnameOverride should be given for resources") }}
{{- end }}
{{- end }}
