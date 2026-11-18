.k

// =========================================================================
// GESTURE NAVIGATION BAR (Taskbar)
// 1. Nhấp chuột vào thanh điều hướng ở cạnh đáy để mở / đóng App Launcher
// 2. Nhấn phím Win (Super) trên bàn phím để mở / đóng App Launcher
// Luôn nằm ở lớp trên cùng (z_index: 9999), đè lên toàn bộ cửa sổ & Launcher
// =========================================================================
printf_div{id: "gesture_container", layout: "absolute", z_index: 9999, x: "center", y: "bottom-4", w: 240, h: 22, background: "transparent", on_click: toggle_launcher}
    button{id: "gesture_bar", text: "", z_index: 9999, x: "center", y: 6, w: 200, h: 8, radius: 4, background: "#FFFFFFFF", border_color: "transparent", on_click: toggle_launcher}
end

// =========================================================================
// XỬ LÝ PHÍM NÓNG BÀN PHÍM (Win / Super Key)
// =========================================================================
action on_key_down(event) {
    // 91: Left Win, 92: Right Win, 219: Win Release/Scan, 227: Super Key
    if event.key == 91 or event.key == 92 or event.key == 219 or event.key == 227 {
        toggle_launcher(event)
    }
    // 1: Phím ESC (Đóng Launcher nếu đang mở, hoặc đóng Cửa sổ nếu đang mở)
    if event.key == 1 {
        if state.get("launcher_visible") {
            toggle_launcher(event)
        } else {
            if state.get("window_visible") {
                close_window(event)
            }
        }
    }
}
