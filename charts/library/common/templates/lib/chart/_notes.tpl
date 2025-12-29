{{- define "asa.v1.common.lib.chart.notes" -}}

  {{- include "asa.v1.common.lib.chart.header" . -}}

  {{- include "asa.v1.common.lib.chart.custom" . -}}

  {{- include "asa.v1.common.lib.chart.footer" . -}}

  {{- include "asa.v1.common.lib.chart.warnings" . -}}

{{- end -}}

{{- define "asa.v1.common.lib.chart.header" -}}
  {{- tpl $.Values.notes.header $ | nindent 0 }}
{{- end -}}

{{- define "asa.v1.common.lib.chart.custom" -}}
  {{- tpl $.Values.notes.custom $ | nindent 0 }}
{{- end -}}

{{- define "asa.v1.common.lib.chart.footer" -}}
  {{- tpl $.Values.notes.footer $ | nindent 0 }}
{{- end -}}

{{- define "asa.v1.common.lib.chart.warnings" -}}
  {{- range $w := $.Values.notes.warnings }}
    {{- tpl $w $ | nindent 0 }}
  {{- end }}
{{- end -}}

{{- define "add.warning" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $warn := .warn -}}

  {{- $newWarns := $rootCtx.Values.notes.warnings -}}
  {{- $newWarns = mustAppend $newWarns $warn -}}
  {{- $_ := set $rootCtx.Values.notes "warnings" $newWarns -}}
{{- end -}}
