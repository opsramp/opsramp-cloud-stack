{{/*
Expand the name of the chart.
*/}}
{{- define "opsramp-cloud-stack.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "opsramp-cloud-stack.fullname" -}}
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
{{- define "opsramp-cloud-stack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "opsramp-cloud-stack.labels" -}}
helm.sh/chart: {{ include "opsramp-cloud-stack.chart" . }}
{{ include "opsramp-cloud-stack.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "opsramp-cloud-stack.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opsramp-cloud-stack.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "opsramp-cloud-stack.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "opsramp-cloud-stack.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Extracing OpenTelemetry Collector Creds
*/}}
{{- define "otel.auth.endpoint" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "ot_endpoint" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "otel.auth.key" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "ot_key" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "otel.auth.secret" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "ot_secret" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "otel.auth.tenantId" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "ot_tenantId" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "otel.endpoint.metrics" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "ot_metrics" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "otel.endpoint.logs" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "ot_logs" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{/*
Extracing OpsRamp Tracing Proxy Creds
*/}}
{{- define "tp.auth.endpoint" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "tp_endpoint" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "tp.auth.key" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "tp_key" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "tp.auth.secret" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "tp_secret" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "tp.auth.tenantId" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "tp_tenantId" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "tp.endpoint.metrics" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "tp_metrics" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "tp.endpoint.logs" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "tp_logs" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}

{{- define "tp.endpoint.traces" -}}
{{- if .Values.global.Token }}
{{ with .Values.global.Token | b64dec }}
{{- get (fromJson .) "tp_traces" | default "" }}
{{ end }}
{{- else }}
{{- "none" }}
{{- end }}
{{- end }}
