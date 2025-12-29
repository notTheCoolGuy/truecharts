{{/* Returns Priority Class Name */}}
{{/* Call this template:
{{ include "asa.v1.common.lib.pod.priorityClassName" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "asa.v1.common.lib.pod.priorityClassName" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $className := "" -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.priorityClassName -}}
    {{- $className = tpl . $rootCtx -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- with $objectData.podSpec.priorityClassName -}}
    {{- $className = tpl . $rootCtx -}}
  {{- end -}}

  {{- $className -}}
{{- end -}}
