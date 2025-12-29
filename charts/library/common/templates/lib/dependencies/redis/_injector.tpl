{{- define "asa.v1.common.lib.dependencies.redis.injector" -}}
  {{- $secret := include "asa.v1.common.lib.dependencies.redis.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret (printf "%s-%s" .Release.Name "rediscreds") $secret -}}
  {{- end -}}
{{- end -}}
