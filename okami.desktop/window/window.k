.k

// =========================================================================
// WINDOW MANAGER CONTAINER IN KMI (Trình Quản Lý & Khung Cửa Sổ Ứng Dụng)
// Cửa sổ kính mờ Acrylic Glass, bo góc tròn 12px, thanh điều khiển
// Thu nhỏ, Phóng to, Đóng, và bảo vệ phân quyền ổ đĩa OM:\ theo chuẩn Okami NT
// =========================================================================

state {
    window_visible: false
    window_maximized: false
    window_app_id: "app_term"
    window_title: "Terminal — esh.okami"
    window_badge: ">_"
    window_exec: "OM:\\System\\Executables\\esh.okami"
    window_status: "RUNNING"
}

// =========================================================================
// FLOATING ACRYLIC WINDOW CONTAINER
// =========================================================================
printf_div{id: "desktop_window", layout: "absolute", z_index: 500, x: "center", y: 90, w: 880, h: 540, radius: 12, background: "#0B1120F2", border_color: "#38BDF860", visible: false}

    // --- Window Titlebar (Header) ---
    printf_div{id: "win_titlebar", layout: "absolute", x: 0, y: 0, w: "fill", h: 44, radius: 12, background: "#1E293BE6", border_color: "transparent"}
        
        // App Badge Icon
        button{id: "win_badge_icon", text: ">_", x: 14, y: 8, w: 28, h: 28, radius: 8, background: "#6366F1", color: "#FFFFFF", border_color: "transparent"}
        
        // Window Title & Status
        text{id: "win_title_text", value: "Terminal — esh.okami", x: 52, y: 13, color: "#F8FAFC", size: 14}
        text{id: "win_status_badge", value: "● RUNNING", x: 300, y: 15, color: "#22C55E", size: 11}
        
        // Window Control Buttons (Top-Right: Minimize, Maximize, Close)
        printf_div{id: "win_controls", layout: "flex-row", gap: 8, x: "right-14", y: 8, w: 104, h: 28, background: "transparent"}
            button{id: "btn_win_min", text: "-", w: 28, h: 28, radius: 6, background: "#33415580", color: "#94A3B8", border_color: "transparent", on_click: minimize_window}
            button{id: "btn_win_max", text: "[ ]", w: 32, h: 28, radius: 6, background: "#33415580", color: "#94A3B8", border_color: "transparent", on_click: toggle_maximize_window}
            button{id: "btn_win_close", text: "X", w: 28, h: 28, radius: 6, background: "#EF4444D0", color: "#FFFFFF", border_color: "transparent", on_click: close_window}
        end
    end

    // --- Sub-header: Process Info Bar (Okami NT User Sandboxing & Permissions) ---
    printf_div{id: "win_infobar", layout: "absolute", x: 0, y: 44, w: "fill", h: 28, background: "#0F172ACC", border_color: "#33415560"}
        text{id: "win_process_info", value: "User: User (Sandboxed) | Working Dir: OM:\\User\\ | Arch: x86_64", x: 16, y: 6, color: "#64748B", size: 11}
        text{id: "win_memory_info", value: "Elevation: None | Root OM:\\ requires ath elevation", x: "right-20", y: 6, color: "#64748B", size: 11}
    end

    // --- Main Window Content Workspace ---
    printf_div{id: "win_workspace", layout: "absolute", x: 12, y: 80, w: 856, h: 446, radius: 8, background: "#050914F0", border_color: "#1E293B80"}
        
        // 1. Terminal Workspace Content (Chuẩn Prompt OM:\User\ & Bảo Vệ Root OM:\)
        printf_div{id: "content_terminal", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", background: "transparent", visible: true}
            text{id: "term_banner1", value: "NETJAN Okami NT Command Shell [Version 20.10.0-SMP]", x: 16, y: 16, color: "#38BDF8", size: 13}
            text{id: "term_banner2", value: "(C) 2026 NETJAN Inc. All rights reserved.", x: 16, y: 34, color: "#64748B", size: 12}
            text{id: "term_banner3", value: "Root drive OM:\\ mounted (Protected). Default Working Directory: OM:\\User\\", x: 16, y: 52, color: "#64748B", size: 12}
            
            // Interactive Shell Area
            text{id: "term_prompt", value: "OM:\\User\\>", x: 16, y: 84, color: "#4ADE80", size: 13}
            text{id: "term_out1", value: "[esh] Standard user session initialized in OM:\\User\\", x: 16, y: 106, color: "#94A3B8", size: 12}
            text{id: "term_out2", value: "[security] Root drive OM:\\ access requires administrator authentication", x: 16, y: 126, color: "#64748B", size: 12}
            text{id: "term_out3", value: "[hint] Typing 'cd ..' or accessing OM:\\ will require admin password", x: 16, y: 146, color: "#64748B", size: 12}
            
            // Terminal Quick Action Bar (Mô Phỏng Phân Quyền & Lệnh Chuẩn Okami NT)
            printf_div{id: "term_actions", layout: "flex-row", gap: 10, x: 16, y: "bottom-16", w: 750, h: 32, background: "transparent"}
                button{id: "btn_term_cd", text: "Test: cd ..", w: 120, h: 30, radius: 6, background: "#1E293B", color: "#F8FAFC", border_color: "#475569", on_click: term_run_cd_parent}
                button{id: "btn_term_ath", text: "Elevate: ath -l", w: 140, h: 30, radius: 6, background: "#1E293B", color: "#F8FAFC", border_color: "#475569", on_click: term_run_ath}
                button{id: "btn_term_ls", text: "Run: ls OM:\\User\\", w: 140, h: 30, radius: 6, background: "#1E293B", color: "#F8FAFC", border_color: "#475569", on_click: term_run_ls_user}
                button{id: "btn_term_clear", text: "Reset Shell", w: 110, h: 30, radius: 6, background: "#334155", color: "#F8FAFC", border_color: "#475569", on_click: term_run_clear}
            end
        end

        // 2. Editor Workspace Content
        printf_div{id: "content_editor", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", background: "transparent", visible: false}
            text{id: "edit_head", value: "File: OM:\\User\\documents\\welcome.txt [UTF-8 Okami]", x: 16, y: 16, color: "#38BDF8", size: 13}
            text{id: "edit_line1", value: "1 | // Okami NT User Space Document", x: 16, y: 44, color: "#94A3B8", size: 13}
            text{id: "edit_line2", value: "2 | Current Directory: OM:\\User\\", x: 16, y: 64, color: "#64748B", size: 13}
            text{id: "edit_line3", value: "3 | Status: Sandboxed User Permission", x: 16, y: 84, color: "#F8FAFC", size: 13}
            text{id: "edit_line4", value: "4 | Root Drive: OM:\\ (Requires ath elevation)", x: 16, y: 104, color: "#F8FAFC", size: 13}
            text{id: "edit_line5", value: "5 | // End of document", x: 16, y: 124, color: "#F8FAFC", size: 13}
        end

        // 3. File Explorer Workspace Content
        printf_div{id: "content_files", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", background: "transparent", visible: false}
            text{id: "files_head", value: "Location: OM:\\User\\ (Root OM:\\ is Protected)", x: 16, y: 16, color: "#38BDF8", size: 13}
            printf_div{id: "files_list", layout: "flex-column", gap: 8, x: 16, y: 44, w: 700, h: 300, background: "transparent"}
                text{id: "f_doc", value: "[DIR]  OM:\\User\\documents\\      - Personal User Documents", color: "#F8FAFC", size: 12}
                text{id: "f_down", value: "[DIR]  OM:\\User\\downloads\\      - Browser & Network Downloads", color: "#F8FAFC", size: 12}
                text{id: "f_wall", value: "[DIR]  OM:\\User\\wallpaper\\      - Desktop Custom Wallpapers", color: "#F8FAFC", size: 12}
                text{id: "f_txt", value: "[FILE] welcome.txt               - 1 KB Text Document", color: "#F8FAFC", size: 12}
                text{id: "f_lock", value: "[LOCK] OM:\\System\\               - Access Denied (Requires Administrator Password)", color: "#EF4444", size: 12}
            end
        end

        // 4. Ping Diagnostic Workspace Content
        printf_div{id: "content_ping", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", background: "transparent", visible: false}
            text{id: "ping_head", value: "AetherNet ICMP Latency Tool (OM:\\System\\Executables\\ping.okami)", x: 16, y: 16, color: "#38BDF8", size: 13}
            text{id: "p_stat1", value: "PING 127.0.0.1 (lo) 56(84) bytes of data.", x: 16, y: 44, color: "#F8FAFC", size: 12}
            text{id: "p_stat2", value: "64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.038 ms", x: 16, y: 64, color: "#4ADE80", size: 12}
            text{id: "p_stat3", value: "64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.041 ms", x: 16, y: 84, color: "#4ADE80", size: 12}
            text{id: "p_stat4", value: "64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.039 ms", x: 16, y: 104, color: "#4ADE80", size: 12}
            text{id: "p_stat5", value: "--- 127.0.0.1 ping statistics --- 3 packets transmitted, 3 received, 0% packet loss", x: 16, y: 130, color: "#E2E8F0", size: 12}
        end

        // 5. Network Manager Workspace Content
        printf_div{id: "content_network", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", background: "transparent", visible: false}
            text{id: "net_head", value: "AetherNet Network Manager — Active Interfaces", x: 16, y: 16, color: "#38BDF8", size: 13}
            text{id: "net_if1", value: "● lo0   : 127.0.0.1/8 (Loopback Device) - MTU 65536 [UP, RUNNING]", x: 16, y: 44, color: "#4ADE80", size: 12}
            text{id: "net_if2", value: "● eth0  : 10.0.2.15/24 (Intel E1000 Gigabit) - MTU 1500 [UP, LINK ACTIVE]", x: 16, y: 64, color: "#4ADE80", size: 12}
            text{id: "net_if3", value: "Gateway : 10.0.2.2 | DNS: 10.0.2.3 | Domain: netjan.local", x: 16, y: 88, color: "#94A3B8", size: 12}
        end

        // 6. Display Settings Workspace Content
        printf_div{id: "content_display", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", background: "transparent", visible: false}
            text{id: "disp_head", value: "Display Settings & Video Resolution Manager", x: 16, y: 16, color: "#38BDF8", size: 13}
            text{id: "disp_cur", value: "Current Mode: 1440 x 900 @ 60 Hz 32bpp Linear Framebuffer", x: 16, y: 44, color: "#F8FAFC", size: 12}
            text{id: "disp_color", value: "Color Space: TrueColor ARGB8888 | Pitch: 5760 bytes/line", x: 16, y: 64, color: "#94A3B8", size: 12}
        end

        // 7. Wallpaper Workspace Content
        printf_div{id: "content_wallpaper", layout: "absolute", x: 0, y: 0, w: "fill", h: "fill", background: "transparent", visible: false}
            text{id: "wall_head", value: "Desktop Wallpaper Gallery (OM:\\User\\wallpaper\\)", x: 16, y: 16, color: "#38BDF8", size: 13}
            text{id: "wall_cur", value: "Active: img.png (Okami Sunset Wheatfield 1440x900)", x: 16, y: 44, color: "#F8FAFC", size: 12}
            text{id: "wall_status", value: "Cached in Hardware Backbuffer: Yes (Zero tearing double-buffer)", x: 16, y: 64, color: "#22C55E", size: 12}
        end
    end
end

// =========================================================================
// WINDOW ACTIONS (Điều Khiển Cửa Sổ)
// =========================================================================
action close_window(event) {
    state.set("window_visible", false)
    ui.set_visible("desktop_window", false)
}

action minimize_window(event) {
    state.set("window_visible", false)
    ui.set_visible("desktop_window", false)
}

action toggle_maximize_window(event) {
    let is_max = state.get("window_maximized")
    if is_max {
        state.set("window_maximized", false)
    } else {
        state.set("window_maximized", true)
    }
}

// Thử cd .. về root OM:\ -> Bị chặn và yêu cầu nhập mật khẩu quản trị viên
action term_run_cd_parent(event) {
    ui.set_text("term_prompt", "OM:\\User\\> cd ..")
    ui.set_text("term_out1", "[ath] Administrator authentication is required to access the root shell.")
    ui.set_text("term_out2", "Password: [ ******** ] -> Access Denied (Incorrect credential)")
    ui.set_text("term_out3", "OM:\\User\\> [Remaining in sandboxed user directory]")
}

// Nâng quyền với ath -l -> Nhập mật khẩu đúng và chuyển sang dấu nhắc OM:\>
action term_run_ath(event) {
    ui.set_text("term_prompt", "OM:\\User\\> ath.okami -l")
    ui.set_text("term_out1", "[ath] Verifying root credential in OM:\\System\\Configuration\\passwd...")
    ui.set_text("term_out2", "[ath] Authentication SUCCESS. Elevated to Administrator (UID 0).")
    ui.set_text("term_out3", "Elevated to root prompt -> OM:\\>")
    ui.set_text("win_process_info", "User: root (UID 0) | Working Dir: OM:\\ | Role: Administrator")
    ui.set_text("win_memory_info", "Elevation: Active (Full Permissions) | Drive: OM:\\")
}

// Liệt kê file trong thư mục OM:\User\
action term_run_ls_user(event) {
    ui.set_text("term_prompt", "OM:\\User\\> ls")
    ui.set_text("term_out1", "documents\\   downloads\\   wallpaper\\   welcome.txt")
    ui.set_text("term_out2", "[status] 3 directories, 1 file (User space accessible)")
    ui.set_text("term_out3", "")
    os.process.launch("OM:\\System\\Executables\\ls.okami")
}

// Reset lại shell về trạng thái ban đầu OM:\User\>
action term_run_clear(event) {
    ui.set_text("term_prompt", "OM:\\User\\>")
    ui.set_text("term_out1", "[esh] Active directory: OM:\\User\\")
    ui.set_text("term_out2", "[security] Root drive OM:\\ access requires administrator authentication")
    ui.set_text("term_out3", "")
    ui.set_text("win_process_info", "User: User (Sandboxed) | Working Dir: OM:\\User\\ | Arch: x86_64")
    ui.set_text("win_memory_info", "Elevation: None | Root OM:\\ requires ath elevation")
}
