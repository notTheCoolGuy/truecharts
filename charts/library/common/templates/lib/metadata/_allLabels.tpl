{{/* Labels that are added to all objects */}}
{{/* Call this template:
{{ include "asa.v1.common.lib.metadata.allLabels" $ }}
*/}}
{{- define "asa.v1.common.lib.metadata.allLabels" -}}
helm.sh/chart: {{ include "asa.v1.common.lib.chart.names.chart" . }}
helm-revision: {{ .Release.Revision | quote }}
app.kubernetes.io/name: {{ include "asa.v1.common.lib.chart.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app: {{ include "asa.v1.common.lib.chart.names.chart" . }}
release: {{ .Release.Name }}
{{- include "asa.v1.common.lib.metadata.globalLabels" . }}
{{- end -}}
