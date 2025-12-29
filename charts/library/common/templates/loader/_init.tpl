{{/* Initialiaze values of the chart */}}
{{- define "asa.v1.common.loader.init" -}}

  {{- include "asa.v1.common.lib.chart.helm.version" . -}}

  {{/* Merge chart values and the common chart defaults */}}
  {{- include "asa.v1.common.values.init" . -}}

  {{/* Ensure TrueCharts chart context information is available */}}
  {{- include "asa.v1.common.lib.util.chartcontext" . -}}

  {{/* Autogenerate redis passwords if needed */}}
  {{- include "asa.v1.common.lib.dependencies.redis.injector" . }}

  {{/* Enable netshoot add-on if required */}}
  {{- if and .Values.addons.netshoot .Values.addons.netshoot.enabled }}
    {{- include "asa.v1.common.addons.netshoot" . }}
  {{- end -}}

  {{/* Append database wait containers to pods */}}
  {{- include "asa.v1.common.lib.deps.wait" $ }}

{{- end -}}
