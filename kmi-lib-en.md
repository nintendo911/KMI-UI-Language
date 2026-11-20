# Okami NT KMI Language & UI Library Specification
**Version:** Prototype specification (implementation status checked against source)  
**Architecture:** C++ KMI compiler and host UI prototype  
**Engine Binary:** `KMILanguage.okami` / `kmi-compiler`  
**Standard Extensions:** `.kmi` (Application Source), `.k` (Header File), `.conf` (Manifest), `.okami` (Custom Source Container)

---

## 1. Architectural Overview & Design Philosophy

The **KMI Language (Okami Modern Interface)** describes UI trees and actions. The native Okami runtime loads the `.kmi` entry and its linked `.k` modules from `app.conf`, then draws a basic UI using Okami's framebuffer, keyboard, and mouse devices. It is not a general-purpose compiler or a replacement for the native compositor and process lifecycle.

### Core Design Principles:
1. **Declarative UI:** UI trees, styles, state, and actions are described declaratively in `.kmi` and `.k` source.
2. **Transparent Modular Headers (`.k`):** Analogous to `.h` in C/C++, shared design systems, styles, palettes, cursors, and system states reside in `.k` header files and are imported using `#link`.
3. **Drawing & Framebuffer:** Low-level rendering operates directly on Framebuffer `/dev/fb0` with non-blocking hardware event forwarders for mouse and keyboard.
4. **Separation of Mechanism & Policy:** The C++ core provides parsing and OS bridging; all visual styling, cursors, and UI logic are owned by `.k` and `.kmi` scripts.

> **Implementation status:** The C++ compiler source is in `modules/KMILanguage`. `make desktop` builds its `KMILanguage.okami` output and copies it to `done/Program/KMILanguage/KMILanguage.okami`; Desktop KMI sources and `app.conf` are under `done/System/okami.desktop`. The compiler produces a KMI package, not an Okami-native ELF executable. Runtime/platform compatibility remains a separate concern.

---

## 2. File Headers & Modular Header System (`#link`)

### 2.1 File Header Signatures
Every KMI source file must declare its type on line 1:
* **Application Layout Files:** Must start with `.kmi\n` or `.kmi\r\n`.
* **Modular Header Files:** Must start with `.k\n` or `.k\r\n`.

### 2.2 The `#link` Directive
Headers and secondary modules are imported before any declarations:

```kmi
.kmi
#link "theme_fluent.k"
#link "system_state.k"

printf_div{id: "main_window", w: "fill", h: "fill", layout: "flex-row"}
    // Reusable styles and state are immediately accessible
end
```

Rules:
* All `#link` directives must appear at the top of the file before any `theme`, `state`, `printf_div`, or `action` block.
* Linked paths must be relative, forward-slash-separated (`/`), and cannot escape the project root (no `..`).
* Cycle detection is strictly enforced by the compiler.

---

## 3. Application Manifest (`app.conf`)

For standard OS applications, a manifest file defines window boundaries and binary metadata:

```ini
[Application]
name = Okami System Settings Hub
id = org.okami.settings
version = 3.0.0
entry = main.kmi
engine = /System/KMILanguage/KMILanguage.okami

[Window]
title = Okami NT - System Settings Hub
width = 1040
height = 740
resizable = false
```

---

## 4. Core Language Syntax

### 4.1 Theme & Design Tokens (`theme`)
Themes declare color palettes, corner radii, and reusable component classes:

```kmi
theme "fluent_dark" {
    color.surface: "#0D1117"
    color.card: "#161B24"
    color.primary: "#38BDF8"
    color.accent: "#34D399"
    color.text: "#F1F5F9"
    color.border: "#262D3D"
    radius.card: 12

    style "content_card" {
        background: "$color.card"
        border_color: "$color.border"
        radius: "$radius.card"
        padding: 14
    }
}
```

### 4.2 State Declarations (`state`)
Defines reactive variables for the application:

```kmi
state {
    os_name: "Okami NT 3.0"
    cpu_usage: 24
    wifi_enabled: true
    sys_volume: 75
}
```

State variables can be interpolated in strings via `${variable_name}` and updated dynamically via `state.set("key", value)`.

### 4.3 Action Declarations (`action`)
Interactive event handlers support local variables (`let`), conditionals (`if`/`else`), exception handling (`try`/`catch`), and runtime function calls:

```kmi
action on_save_config(event) {
    let current_ip = state.get("ip_addr")
    if (current_ip != "") {
        file.write("/System/Config/network.conf", current_ip)
        ui.toast("Network configuration saved!", "success")
    } else {
        ui.alert("IP address cannot be empty!", "Error")
    }
}
```

---

## 5. Declarative UI Component Reference

All nodes support standard layout attributes: `id`, `w`, `h`, `class`, `background`, `border_color`, `radius`.

### 5.1 `printf_div` / `div` (Flexbox Layout Container)
Containers support `flex-row` and `flex-column` layouts with `gap` and `padding`:

```kmi
printf_div{id: "sidebar", class: "sidebar_box", w: 240, h: "fill", layout: "flex-column", gap: 10}
    // Child elements
end
```

### 5.2 `text` (Typography)
High-precision text rendering:
* `value`: The string content (supports `${state}` interpolation).
* `color`: Hex color or `$color.token`.
* `size`: Font point size (e.g. `14`).
* `weight`: `"regular"`, `"medium"`, `"semibold"`, or `"bold"`.

```kmi
text{id: "lbl_header", value: "Welcome to ${os_name}", color: "$color.text", size: 16, weight: "bold"}
```

### 5.3 `button` (Interactive Buttons)
* `text`: Button label.
* `variant`: `""` (standard), `"active"` (accent-outlined), or `"primary"` (filled accent).
* `on_click`: Action name to execute when pressed.

```kmi
button{id: "btn_save", text: "Save Changes", variant: "primary", w: 120, h: 32, on_click: on_save_config}
```

### 5.4 `slider` (Range Value Controls)
* `min`, `max`, `step`: Value boundaries.
* `value`: Current integer value.
* `on_change`: Action name called during dragging.

```kmi
slider{id: "sl_vol", min: 0, max: 100, step: 1, value: 75, on_change: on_volume_change}
```

### 5.5 `checkbox` / `switch` (Fluent Toggle Switches)
Renders a modern iOS / Windows 11 Fluent 42x22px toggle track with an animated circular knob:
* `text`: Accompanying label.
* `checked`: Boolean state (`true` / `false`).
* `on_change`: Action name executed upon toggling.

```kmi
checkbox{id: "sw_wifi", text: "Wi-Fi Interface", checked: true, on_change: on_toggle_wifi}
```

### 5.6 `input` (Text Input Field)
Supports direct UTF-16 typing, Unicode character input, Backspace (`VK_BACK`), Enter submit, and active focus styling:
* `value`: Input text content.
* `placeholder`: Ghost hint text when empty.
* `on_input`: Action triggered upon every keystroke.
* `on_submit`: Action triggered when the Enter key is pressed.

```kmi
input{id: "txt_dev_name", value: "Okami-Station", w: 220, h: 30, on_submit: on_apply_dev_name}
```

### 5.7 `separator` (Visual Divider)
Draws a subtle 1px acrylic divider line.

```kmi
separator{id: "sep_1"}
```

### 5.8 `icon` (Vector System Icons)
Renders crisp vector symbols: `"terminal"`, `"display"`, `"sound"`, `"wifi"`, `"bluetooth"`, `"battery"`, `"settings"`, `"search"`, `"user"`.

```kmi
icon{id: "ico_net", name: "wifi", color: "$color.primary"}
```

### 5.9 `canvas` (Direct 2D Pixel Graphics Surface)
A dedicated hardware canvas region that executes custom 2D drawing routines:
* `on_draw`: Action name called to render custom graphics.

```kmi
canvas{id: "cv_monitor", w: "fill", h: 100, on_draw: on_draw_metrics}
```

### 5.10 `image` / `img` (Bitmap Graphics & Wallpapers)
Renders external bitmap images for desktop backgrounds, avatars, and file previews:
* `src`: Relative or absolute path to `.bmp` image file.

```kmi
image{id: "img_wallpaper", src: "assets/wallpaper.bmp", w: "fill", h: "fill"}
```

---

## 6. Direct 2D Pixel Graphics API (`draw.*`)

The `draw.*` API exposes the full power of Okami's framebuffer drawing engine inside `canvas` rendering actions:

| Function | Syntax | Description |
|---|---|---|
| `draw.clear` | `draw.clear(color)` | Clears the canvas with the specified color. |
| `draw.pixel` | `draw.pixel(x, y, color)` | Plots an individual pixel at coordinate `(x, y)`. |
| `draw.line` | `draw.line(x1, y1, x2, y2, color, [thickness])` | Draws a vector line between two points. |
| `draw.rect` | `draw.rect(x, y, w, h, color, [thickness])` | Outlines a rectangular boundary. |
| `draw.fill_rect` | `draw.fill_rect(x, y, w, h, color)` | Fills a solid rectangle. |
| `draw.rounded_rect` | `draw.rounded_rect(x, y, w, h, radius, fill, [border])` | Draws a Fluent rounded rectangle with optional border. |
| `draw.circle` | `draw.circle(x, y, radius, color, [thickness])` | Outlines a circular boundary. |
| `draw.fill_circle` | `draw.fill_circle(x, y, radius, color)` | Fills a solid circle. |
| `draw.gradient_v` | `draw.gradient_v(x, y, w, h, top_col, bot_col)` | Vertical linear gradient fill. |
| `draw.gradient_h` | `draw.gradient_h(x, y, w, h, left_col, right_col)` | Horizontal linear gradient fill. |
| `draw.text` | `draw.text(x, y, text, color, [size], [bold])` | Renders a string directly at `(x, y)`. |
| `draw.reset` | `draw.reset()` | Clears the draw command buffer for a fresh frame. |

### Example Canvas Draw Action:
```kmi
action on_draw_metrics(event) {
    draw.reset()
    draw.gradient_v(0, 0, 800, 100, "#10141D", "#0A0D12")
    draw.line(0, 50, 800, 50, "#1F2838", 1)
    draw.rounded_rect(40, 20, 20, 60, 4, "#38BDF8")
    draw.rounded_rect(70, 35, 20, 45, 4, "#38BDF8")
    draw.line(40, 30, 120, 50, "#34D399", 2)
    draw.text(10, 10, "Realtime Activity", "#F1F5F9", 12, true)
}
```

---

## 7. Specified Runtime APIs (Not All Implemented)

The lists in this section describe intended APIs. They are not a complete or
verified inventory of `UiRuntime::call_builtin`; consult
`include/kmi_runtime.hpp` for current implementation. In particular, documented
OS APIs must not be assumed to exist on Okami OS or to have restricted
permissions.

### 7.1 State Management (`state.*`)
* `state.get(key)`: Retrieves a state variable.
* `state.set(key, value)`: Updates a state variable and triggers automatic UI redraw.
* `state.has(key)`: Checks if a state variable exists.
* `state.reset([key])`: Resets variable (or entire state) to initial values.
* `state.toggle(key)`: Inverts a boolean state variable.
* `state.increment(key, [step])`: Increments a number by `step` (default: 1).
* `state.decrement(key, [step])`: Decrements a number by `step` (default: 1).

### 7.2 UI Manipulation (`ui.*`)
* `ui.exists(id)`: Checks if a component exists in the active layout tree.
* `ui.get_value(id)`: Reads value from input, slider, or switch.
* `ui.set_value(id, val)`: Programmatically updates element value.
* `ui.get_text(id)`: Gets text from label or button.
* `ui.set_text(id, str)`: Sets text of label or button.
* `ui.set_visible(id, bool)`: Shows or hides a component.
* `ui.set_enabled(id, bool)`: Enables or disables user interaction.
* `ui.toast(msg, [level])`: Displays a lightweight toast notification (`"info"`, `"success"`, `"warning"`).
* `ui.alert(msg, [title])`: Displays a modal dialog box.
* `ui.confirm(msg, [title])`: Displays an OK/Cancel confirmation dialog (returns `bool`).
* `ui.set_title(title)`: Dynamically changes window title.
* `ui.close()`: Gracefully closes the window.

### 7.3 System & Hardware Bridge (`sys.*`)
* `sys.time()`: Returns current system time (`"HH:MM:SS"`).
* `sys.date()`: Returns current system date (`"YYYY-MM-DD"`).
* `sys.timestamp()`: Returns current Unix epoch timestamp in seconds.
* `sys.platform()`: Returns OS platform string.
* `sys.beep([freq], [ms])`: Emits a hardware beep tone (e.g. `880`, `200`).
* `sys.clipboard_copy(text)`: Copies string to system clipboard.
* `sys.clipboard_paste()`: Reads string from system clipboard.
* `sys.spawn(path, [args])`: Launches an external process asynchronously.
* `sys.exec(cmd)`: Executes a shell command synchronously.
* `sys.exec_output(cmd)`: Executes shell command and captures standard output.
* `sys.cpu_usage()`: Reads actual hardware CPU utilization percentage (0 - 100).
* `sys.battery()`: Returns map with `{level, charging, ac_plugged}`.
* `sys.memory_info()`: Returns map with total, free, and used RAM metrics.
* `sys.screen_size()`: Returns map with `{width, height}`.
* `sys.kill(pid)`: Terminates a running process by PID.
* `sys.exit([code])`: Terminates the current application.
* `sys.reboot()`: Issues system reboot command.
* `sys.shutdown()`: Issues system power-off command.

### 7.4 High-Precision Timers (`timer.*`)
* `timer.every(interval_ms, action_name)`: Starts a repeating interval timer.
* `timer.after(delay_ms, action_name)`: Starts a single-shot delayed timer.
* `timer.clear(timer_id)`: Cancels an active timer.

### 7.5 File & Directory I/O (`file.*`, `dir.*`, `path.*`)
* `file.exists(path)`, `file.read(path)`, `file.write(path, data)`, `file.append(path, data)`, `file.delete(path)`, `file.size(path)`.
* `dir.list(path)`: Returns list of file maps `{name, path, is_dir, size}`.
* `dir.create(path)`, `dir.exists(path)`, `dir.delete(path)`.
* `path.join(p1, p2)`, `path.filename(p)`, `path.extension(p)`, `path.parent(p)`.

### 7.6 Data Structures (`list.*`, `map.*`)
* `list.size(l)`, `list.get(l, idx)`, `list.push(l, val)`, `list.pop(l)`, `list.clear(l)`.
* `map.has(m, key)`, `map.get(m, key)`, `map.set(m, key, val)`, `map.keys(m)`, `map.remove(m, key)`.

### 7.7 String & Text Operations (`text.*`)
* `text.length(s)`: Returns character count of string.
* `text.is_empty(s)`: Returns `true` if string is empty.
* `text.trim(s)`: Strips leading and trailing whitespace.
* `text.lower(s)`: Converts string to lowercase.
* `text.upper(s)`: Converts string to uppercase.
* `text.contains(s, sub)`: Checks if substring exists in `s`.
* `text.starts_with(s, prefix)`: Checks prefix match.
* `text.ends_with(s, suffix)`: Checks suffix match.
* `text.replace(s, target, repl)`: Replaces occurrences of `target` with `repl`.
* `text.slice(s, start, [len])`: Extracts substring slice.
* `text.to_int(s)`: Parses string to 64-bit integer.
* `text.to_string(val)`: Converts any value to string.
* `text.concat(s1, s2)`: Concatenates two strings.

### 7.8 Mathematical Utilities (`math.*`)
* `math.min(a, b)`: Returns smaller of two numbers.
* `math.max(a, b)`: Returns larger of two numbers.
* `math.clamp(v, min, max)`: Clamps value within range `[min, max]`.
* `math.abs(v)`: Absolute value.
* `math.round(v)`: Rounds to nearest integer.
* `math.floor(v)`: Floor integer.
* `math.ceil(v)`: Ceiling integer.
* `math.sqrt(v)`: Square root.
* `math.pow(base, exp)`: Exponential power ($base^{exp}$).
* `math.random([min], [max])`: Pseudo-random integer between `min` and `max`.

### 7.9 Process & System Bridge (`os.*` / `sys.*`)
* `os.process.launch(path)`: Launches a binary executable (`/System/Executables/*.okami`). Alias of `sys.spawn`.
* `os.process.exec(cmd)`: Executes a system command synchronously. Alias of `sys.exec`.
* `os.system.reboot()`: Issues a hardware reboot request to Okami NT. Alias of `sys.reboot`.
* `os.system.shutdown()`: Issues an ACPI/firmware power-off request. Alias of `sys.shutdown`.
* `sys.spawn(path)`: Launches an external process asynchronously (fork/execve).
* `sys.exec(cmd)`: Executes a shell command synchronously.
* `sys.exec_output(cmd)`: Executes shell command and captures standard output.
* `sys.reboot()`: Issues system reboot command.
* `sys.shutdown()`: Issues system power-off command.
* `sys.kill(pid)`: Terminates a running process by PID.
* `sys.exit([code])`: Terminates the current application.
* `sys.time()`, `sys.date()`, `sys.timestamp()`: Time and date queries.
* `sys.platform()`: Returns OS platform string.
* `sys.cpu_usage()`: Reads CPU utilization percentage (0 - 100).
* `sys.memory_info()`: Returns map with total, free, and used RAM metrics.
* `sys.screen_size()`: Returns map with `{width, height}`.
* `sys.battery()`: Returns map with `{level, charging, ac_plugged}`.
* `sys.clipboard_copy(text)`, `sys.clipboard_paste()`: System clipboard operations.
* `sys.beep([freq], [ms])`: Emits hardware audio beep tone.

### 7.10 JSON Data Serialization (`json.*`)
* `json.parse(str)`: Deserializes standard JSON string into KMI Map, List, or primitives.
* `json.stringify(val)`: Serializes KMI Map, List, or primitives into standard JSON string.

### 7.11 Network Operations (`net.*`)
* `net.ping(host)`: Pings a remote or local network destination.

---

## 8. Custom `.okami` Container (Prototype)

The writer stores application metadata and module source strings in a custom
container. The reader parses the stored source again when loading it. This is
not ELF, native machine code, or a standalone executable, and it does not
currently package arbitrary resources such as images.

### 8.1 Binary Container Layout
```
+-------------------------------------------------------------+
| 0x00 - 0x07: Magic: 0x7F 'O' 'K' 'A' 'M' 'I' 0x01 0x00     |
+-------------------------------------------------------------+
| 0x08 - 0x0B: uint32_t Version (1)                           |
+-------------------------------------------------------------+
| 0x0C - 0x13: int32_t window_width, int32_t window_height    |
+-------------------------------------------------------------+
| Serialized Metadata Strings:                                |
|   app_id, app_name, version, window_title, entry, engine    |
+-------------------------------------------------------------+
| uint32_t module_count                                       |
| For each module:                                            |
|   path string, source payload, link dependency table        |
+-------------------------------------------------------------+
| 4-byte fixed footer marker: 0xAA 0x55 'O' 'K'               |
+-------------------------------------------------------------+
```

Integers are written in the host's byte representation; the format does not
currently define cross-endian serialization. The footer is a marker, not an
integrity checksum. The reader should not be treated as safe for untrusted
containers.

### 8.2 Compiler Toolchain CLI Commands

```bash
# 1. Package application metadata and source into a .okami container:
./KMILanguage.okami app.conf -o my_app.okami
./KMILanguage.okami main.kmi -o my_app.okami

# 2. Load a .okami container through the host engine (source is parsed on load):
./KMILanguage.okami my_app.okami

# 3. Directly run from source .kmi or .conf:
./KMILanguage.okami app.conf
./KMILanguage.okami main.kmi --run

# 4. Export intermediate JSON IR manifest:
./KMILanguage.okami main.kmi -o manifest.json
```

---

## 9. Architecture: Separation of Mechanism and Policy

* **Pure Engine Core (Mechanism):** All Win32 GDI legacy rendering and hardcoded desktop policies have been removed from the C++ core (`kmi_native_gui.hpp`, `kmi_runtime.hpp`). The engine operates strictly as an OS mediator (Linux `/dev/fb0` double-buffered blitting, non-blocking hardware event polling from `/System/Devices/mouse` and `/System/Devices/kbd`).
* **Desktop Policy in `.k` & `.kmi`:** All UI styling, window layouts, taskbar gesture bars, launchers, themes, and wallpapers are defined purely in outer `.k` and `.kmi` scripts (including taskbar click hit-boxes and Super/Windows key bindings).
* **Hardware Event Forwarding:** Raw hardware keyboard and mouse events are dispatched cleanly to the AST runtime (`on_key_down`, `on_click`), enabling user-defined keyboard shortcuts and gestures without C++ engine coupling.
* **Pure KMI High-DPI Pixel Matrix Cursor:** External binary image files (`cursor.png`) are completely eliminated. The cursor is defined 100% in KMI script syntax ([cursor.k](file:///d:/Okami_NT/done/System/okami.desktop/cursor/cursor.k)) via the High-DPI $31 \times 48$ `cursor_pixels` matrix and `cursor_palette` multi-level anti-aliasing shades, rendering crisp rounded curves without jagged pixel artifacts directly on the framebuffer.
