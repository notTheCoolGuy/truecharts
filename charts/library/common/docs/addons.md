---
title: Addons
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/truecharts-common/addons#full-examples) section for complete examples.

:::

## Appears in

- `.Values.addons`

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `addons`

Addons to the workloads

|            |          |
| ---------- | -------- |
| Key        | `addons` |
| Type       | `map`    |
| Required   | ❌        |
| Helm `tpl` | ❌        |
| Default    | `{}`     |

Example

```yaml
addons: {}
```

---

### `addons.$addon`

COnfigure the addon

:::note

Available addons:

- Netshoot

:::

|            |                 |
| ---------- | --------------- |
| Key        | `addons.$addon` |
| Type       | `map`           |
| Required   | ✅               |
| Helm `tpl` | ❌               |
| Default    | `{}`            |

Example

```yaml
addons:
  netshoot: {}
```

---

#### `addons.$addon.enabled`

Enables or Disables the Addon

|            |                         |
| ---------- | ----------------------- |
| Key        | `addons.$addon.enabled` |
| Type       | `bool`                  |
| Required   | ✅                       |
| Helm `tpl` | ❌                       |
| Default    | `false`                 |

Example

```yaml
addons:
  netshoot:
    enabled: true
```

---

#### `addons.$addon.targetSelector`

Define the workloads to add the addon to

|            |                                |
| ---------- | ------------------------------ |
| Key        | `addons.$addon.targetSelector` |
| Type       | `list` of `string`             |
| Required   | ❌                              |
| Helm `tpl` | ❌                              |
| Default    | `["main"]`                     |

Example

```yaml
addons:
  netshoot:
    targetSelector:
      - main
      - other-workload
```

---

#### `addons.$addon.container`

Define additional options for the container

:::tip

See container options in the [container](/truecharts-common/container) section.

:::

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `addons.$addon.container`                       |
| Type       | `map`                                           |
| Required   | ❌                                               |
| Helm `tpl` | ❌                                               |
| Default    | Depends on the addon (See common's values.yaml) |

Example

```yaml
addons:
  netshoot:
    container: {}
```

---

## Full Examples

```yaml
addons:
  netshoot:
    enabled: true
    container:
      resources:
        limits:
          cpu: 3333m
          memory: 3333Mi
      command:
        - /bin/sh
        - -c
        - sleep infinity
```
