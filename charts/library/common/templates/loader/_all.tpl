{{/* Main entrypoint for the library */}}
{{- define "asa.v1.common.loader.all" -}}

  {{- include "asa.v1.common.loader.init" . -}}

  {{- include "asa.v1.common.loader.apply" . -}}

{{- end -}}
