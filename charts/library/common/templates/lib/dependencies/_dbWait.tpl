{{- define "tc.v1.common.lib.deps.wait" -}}
  {{- if .Values.redis.enabled -}}
    {{- $container := include "tc.v1.common.lib.deps.wait.redis" $ | fromYaml -}}
    {{- if $container -}}
      {{- range .Values.workload -}}
        {{- if not (hasKey .podSpec "initContainers") -}}
          {{- $_ := set .podSpec "initContainers" dict -}}
        {{- end -}}
      {{- $_ := set .podSpec.initContainers "redis-wait" $container -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}

{{- define "tc.v1.common.lib.deps.wait.redis" -}}
enabled: true
type: system
imageSelector: redisClientImage
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  privileged: false
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    add: []
    drop:
      - ALL
resources:
  excludeExtra: true
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 500m
    memory: 512Mi
env:
  REDIS_HOST:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "rediscreds" }}'
      key: plainhost
  REDIS_PASSWORD: "{{ .Values.redis.password }}"
  REDIS_PORT: "6379"
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/bash <<'EOF'
    echo "Executing DB waits..."
    [[ -n "$REDIS_PASSWORD" ]] && export REDISCLI_AUTH="$REDIS_PASSWORD";
    export LIVE=false;
    until "$LIVE";
    do
      response=$(
          timeout -s 3 2 \
          valkey-cli \
            -h "$REDIS_HOST" \
            -p "$REDIS_PORT" \
            ping
        )
      if [ "$response" == "PONG" ] || [ "$response" == "LOADING Redis is loading the dataset in memory" ]; then
        LIVE=true
        echo "$response"
        echo "Redis Responded, ending initcontainer and starting main container(s)..."
      else
        echo "$response"
        echo "Redis not responding... Sleeping for 10 sec..."
        sleep 10
      fi;
    done
    EOF
{{- end -}}
