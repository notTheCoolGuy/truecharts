{{/* Configmap Spawwner */}}
{{/* Call this template:
{{ include "asa.v1.common.spawner.configmap" $ -}}
*/}}

{{- define "asa.v1.common.spawner.configmap" -}}
  {{- $fullname := include "asa.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $configmap := .Values.configmap -}}

    {{- $enabled := (include "asa.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $configmap
                    "name" $name "caller" "ConfigMap"
                    "key" "configmap")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the configmap */}}
      {{- $objectData := (mustDeepCopy $configmap) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "asa.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "ConfigMap"
                "key" "configmap")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "asa.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}} {{/* Configmaps have a max name length of 253 */}}
      {{- include "asa.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "asa.v1.common.lib.configmap.validation" (dict "objectData" $objectData) -}}
      {{- include "asa.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "ConfigMap") -}}

      {{/* Set the name of the configmap */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "asa.v1.common.class.configmap" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
