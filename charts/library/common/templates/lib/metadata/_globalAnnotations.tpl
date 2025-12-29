{{/* Returns the global annotations */}}
{{- define "asa.v1.common.lib.metadata.globalAnnotations" -}}

  {{- include "asa.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" .Values.global.annotations) -}}

{{- end -}}
