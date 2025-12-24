---
title: Global
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/truecharts-common/global#full-examples) section for complete examples.

:::

## Appears in

- `.Values.global`

---

## Defaults

```yaml
global:
  labels: {}
  annotations: {}
  namespace: ""
  minNodePort: 9000
  stopAll: false
```

---

## `labels`

Additional Labels that apply to all objects

|            |                   |
| ---------- | ----------------- |
| Key        | `global.labels`   |
| Type       | `map`             |
| Required   | ❌                 |
| Helm `tpl` | ✅ (On value only) |
| Default    | `{}`              |

Example

```yaml
global:
  labels:
    key: value
```

---

## `annotations`

Additional Annotations that apply to all objects

|            |                      |
| ---------- | -------------------- |
| Key        | `global.annotations` |
| Type       | `map`                |
| Required   | ❌                    |
| Helm `tpl` | ✅ (On value only)    |
| Default    | `{}`                 |

Example

```yaml
global:
  annotations:
    key: value
```

---

## `namespace`

Namespace to apply to all objects, also applies to chart deps

|            |                    |
| ---------- | ------------------ |
| Key        | `global.namespace` |
| Type       | `string`           |
| Required   | ❌                  |
| Helm `tpl` | ✅                  |
| Default    | `""`               |

Example

```yaml
global:
  namespace: ""
```

---

## `minNodePort`

Minimum Node Port Allowed

|            |                      |
| ---------- | -------------------- |
| Key        | `global.minNodePort` |
| Type       | `int`                |
| Required   | ✅                    |
| Helm `tpl` | ❌                    |
| Default    | `9000`               |

Example

```yaml
global:
  minNodePort: 9000
```

---

## `stopAll`

Applies different techniques to stop all objects in the chart and its dependencies

|            |                  |
| ---------- | ---------------- |
| Key        | `global.stopAll` |
| Type       | `bool`           |
| Required   | ❌                |
| Helm `tpl` | ❌                |
| Default    | `false`          |

Example

```yaml
global:
  stopAll: false
```

## Full Examples

```yaml
global:
  labels:
    key: value
  annotations:
    key: value
  namespace: ""
  minNodePort: 9000
  stopAll: false
```
