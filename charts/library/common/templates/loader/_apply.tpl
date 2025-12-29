{{/* Loads all spawners */}}
{{- define "asa.v1.common.loader.apply" -}}

  {{/* Inject custom tpl files, as defined in values.yaml */}}
  {{- include "asa.v1.common.spawner.extraTpl" . | nindent 0 -}}

  {{/* Ensure automatic permissions containers are injected */}}
  {{- include "asa.v1.common.lib.util.autoperms.job" $ -}}

  {{/* Make sure there are not any YAML errors */}}
  {{- include "asa.v1.common.values.validate" .Values -}}

  {{/* Render ConfigMap(s) */}}
  {{- include "asa.v1.common.spawner.configmap" . | nindent 0 -}}

  {{/* Render priorityclass(s) */}}
  {{- include "asa.v1.common.spawner.priorityclass" . | nindent 0 -}}

  {{/* Render Secret(s) */}}
  {{- include "asa.v1.common.spawner.secret" . | nindent 0 -}}

  {{/* Render Image Pull Secrets(s) */}}
  {{- include "asa.v1.common.spawner.imagePullSecret" . | nindent 0 -}}

  {{/* Render Service Accounts(s) */}}
  {{- include "asa.v1.common.spawner.serviceAccount" . | nindent 0 -}}

  {{/* Render RBAC(s) */}}
  {{- include "asa.v1.common.spawner.rbac" . | nindent 0 -}}

  {{/* Render Workload(s) */}}
  {{- include "asa.v1.common.spawner.workload" . | nindent 0 -}}

  {{/* Render Services(s) */}}
  {{- include "asa.v1.common.spawner.service" . | nindent 0 -}}

  {{/* Render storageClass(s) */}}
  {{- include "asa.v1.common.spawner.storageclass" . | nindent 0 -}}

  {{/* Render PVC(s) */}}
  {{- include "asa.v1.common.spawner.pvc" . | nindent 0 -}}

  {{/* Render volumeSnapshot(s) */}}
  {{- include "asa.v1.common.spawner.volumesnapshot" . | nindent 0 -}}

  {{/* Render volumeSnapshotClass(s) */}}
  {{- include "asa.v1.common.spawner.volumesnapshotclass" . | nindent 0 -}}

  {{/* Render ingress(s) */}}
  {{- include "asa.v1.common.spawner.ingress" . | nindent 0 -}}

  {{/* Render Gateway API Route(s) */}}
  {{- include "asa.v1.common.spawner.routes" . | nindent 0 -}}

  {{/* Render Horizontal Pod Autoscalers(s) */}}
  {{- include "asa.v1.common.spawner.hpa" . | nindent 0 -}}

  {{/* Render Networkpolicy(s) */}}
  {{- include "asa.v1.common.spawner.networkpolicy" . | nindent 0 -}}

  {{/* Render podDisruptionBudget(s) */}}
  {{- include "asa.v1.common.spawner.podDisruptionBudget" . | nindent 0 -}}

  {{/* Render webhook(s) */}}
  {{- include "asa.v1.common.spawner.webhook" . | nindent 0 -}}

  {{/* Render Prometheus Metrics(s) */}}
  {{- include "asa.v1.common.spawner.metrics" . | nindent 0 -}}

  {{/* Render Vertical Pod Autoscaler */}}
  {{ include "asa.v1.common.spawner.vpa" . | nindent 0 -}}

{{- end -}}
