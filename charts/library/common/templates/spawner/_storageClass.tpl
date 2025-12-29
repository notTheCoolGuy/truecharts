{{/* Configmap Spawwner */}}
{{/* Call this template:
{{ include "asa.v1.common.spawner.storageclass" $ -}}
*/}}

{{- define "asa.v1.common.spawner.storageclass" -}}
  {{- $fullname := include "asa.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $storageclass := .Values.storageClass -}}

    {{- $enabled := (include "asa.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $storageclass
                    "name" $name "caller" "Storage Class"
                    "key" "storageClass")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the storageclass */}}
      {{- $objectData := (mustDeepCopy $storageclass) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "asa.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Storage Class"
                "key" "storageClass")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "asa.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}} {{/* Configmaps have a max name length of 253 */}}
      {{- include "asa.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "asa.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "StorageClass") -}}

      {{/* Set the name of the storageclass */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Validate */}}
      {{- include "asa.v1.common.lib.storageclass.validation" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{/* Call class to create the object */}}
      {{- include "asa.v1.common.class.storageclass" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
