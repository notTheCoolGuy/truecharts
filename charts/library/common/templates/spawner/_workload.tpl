{{/* Workload Spawner */}}
{{/* Call this template:
{{ include "asa.v1.common.spawner.workload" $ -}}
*/}}

{{- define "asa.v1.common.spawner.workload" -}}
  {{- $fullname := include "asa.v1.common.lib.chart.names.fullname" $ -}}

  {{/* Primary validation for enabled workload. */}}
  {{- include "asa.v1.common.lib.workload.primaryValidation" $ -}}

  {{- range $name, $workload := .Values.workload -}}

    {{- $enabled := (include "asa.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $workload
                    "name" $name "caller" "Workload"
                    "key" "workload")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the workload */}}
      {{- $objectData := (mustDeepCopy $workload) -}}

      {{/* Generate the name of the workload */}}
      {{- $objectName := $fullname -}}
      {{- if not $objectData.primary -}}
        {{- $objectName = printf "%s-%s" $fullname $name -}}
      {{- end -}}

      {{- include "asa.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform validations */}}
      {{- include "asa.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
      {{- include "asa.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Workload") -}}

      {{/* Set the name of the workload */}}
      {{- $_ := set $objectData "name" $objectName -}}

      {{/* Short name is the one that defined on the chart, used on selectors */}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Set the podSpec so it doesn't fail on nil pointer */}}
      {{- if not (hasKey $objectData "podSpec") -}}
        {{- fail "Workload - Expected [podSpec] key to exist" -}}
      {{- end -}}

      {{/* Call class to create the object */}}
      {{- if eq $objectData.type "Deployment" -}}
        {{- include "asa.v1.common.class.deployment" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "StatefulSet" -}}
        {{- include "asa.v1.common.class.statefulset" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "DaemonSet" -}}
        {{- include "asa.v1.common.class.daemonset" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "Job" -}}
        {{- include "asa.v1.common.class.job" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- else if eq $objectData.type "CronJob" -}}
        {{- include "asa.v1.common.class.cronjob" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- end -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
