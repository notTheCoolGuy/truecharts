{{/* Returns tcpSocket action */}}
{{/* Call this template:
{{ include "asa.v1.common.lib.container.actions.tcpSocket" (dict "rootCtx" $ "objectData" $objectData "caller" $caller) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "asa.v1.common.lib.container.actions.tcpSocket" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $caller := .caller -}}

   {{- if not $objectData.port -}}
    {{- fail (printf "Container - Expected non-empty [%s] [port] on [tcp] type" $caller) -}}
  {{- end -}}

  {{- $port := $objectData.port -}}

  {{- if kindIs "string" $port -}}
    {{- $port = tpl $port $rootCtx -}}
  {{- end }}
tcpSocket:
  port: {{ $port }}
{{- end -}}
