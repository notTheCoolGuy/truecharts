{{- define "tc.v1.common.lib.dependencies.redis.injector" -}}
  {{- $secret := include "tc.v1.common.lib.dependencies.redis.secret" . | fromYaml -}}
  {{- if $secret -}}
    {{- $_ := set .Values.secret (printf "%s-%s" .Release.Name "rediscreds") $secret -}}
  {{- end -}}
{{- end -}}
