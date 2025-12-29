{{/* Service Account Spawner */}}
{{/* Call this template:
{{ include "asa.v1.common.spawner.serviceAccount" $ -}}
*/}}

{{- define "asa.v1.common.spawner.serviceAccount" -}}
  {{- $fullname := include "asa.v1.common.lib.chart.names.fullname" $ -}}

  {{/* Primary validation for enabled service accounts. */}}
  {{- include "asa.v1.common.lib.serviceAccount.primaryValidation" $ -}}

  {{- range $name, $serviceAccount := .Values.serviceAccount -}}
    {{- $enabled := (include "asa.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $serviceAccount
                    "name" $name "caller" "Service Account"
                    "key" "serviceAccount")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the configmap */}}
      {{- $objectData := (mustDeepCopy $serviceAccount) -}}

      {{- $objectName := $fullname -}}
      {{- if not $objectData.primary -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "asa.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "asa.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "asa.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Service Account") -}}

      {{/* Set the name of the service account */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "asa.v1.common.class.serviceAccount" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
