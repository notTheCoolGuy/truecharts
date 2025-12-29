{{/* Returns the global labels */}}
{{- define "asa.v1.common.lib.metadata.globalLabels" -}}

  {{- include "asa.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" .Values.global.labels) -}}

{{- end -}}
