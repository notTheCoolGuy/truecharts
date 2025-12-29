{{/* Annotations that are added to all objects */}}
{{/* Call this template:
{{ include "asa.v1.common.lib.metadata.allAnnotations" $ }}
*/}}
{{- define "asa.v1.common.lib.metadata.allAnnotations" -}}
  {{/* Currently empty but can add later, if needed */}}
{{- include "asa.v1.common.lib.metadata.globalAnnotations" . }}

{{- end -}}
