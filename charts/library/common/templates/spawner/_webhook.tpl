{{/* MutatingWebhookConfiguration Spawwner */}}
{{/* Call this template:
{{ include "asa.v1.common.spawner.webhook" $ -}}
*/}}

{{- define "asa.v1.common.spawner.webhook" -}}
  {{- $fullname := include "asa.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $mutatingWebhookConfiguration := .Values.webhook -}}

    {{- $enabled := (include "asa.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $mutatingWebhookConfiguration
                    "name" $name "caller" "Webhook"
                    "key" "webhook")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the mutatingWebhookConfiguration */}}
      {{- $objectData := (mustDeepCopy $mutatingWebhookConfiguration) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "asa.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Webhook"
                "key" "webhook")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{- include "asa.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "asa.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "asa.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Webhook") -}}

      {{/* Set the name of the MutatingWebhookConfiguration */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{- include "asa.v1.common.lib.webhook.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{- $type := tpl $objectData.type $ -}}
      {{/* Call class to create the object */}}
      {{- if eq $type "validating" -}}
        {{- include "asa.v1.common.class.validatingWebhookconfiguration" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $type "mutating" -}}
        {{- include "asa.v1.common.class.mutatingWebhookConfiguration" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- end -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
