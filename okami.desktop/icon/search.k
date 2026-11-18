.k

// =========================================================================
// THUẬT TOÁN VẼ BIỂU TƯỢNG TÌM KIẾM VECTOR (icon/search.k)
// Kính lúp tìm kiếm chuẩn Retina Vector Anti-Aliased (SDF + 3x3 Supersampling)
// Toàn bộ tọa độ tâm thấu kính, bán kính, góc vát tay cầm 45 độ và màu sắc
// được chuyển sang file .k để dễ bảo trì, giữ nguyên trạng hiển thị mượt mà.
// =========================================================================

state {
    search_icon_enabled: true
    search_icon_w: 20
    search_icon_h: 20

    // 1. THUẬT TOÁN TỌA ĐỘ VECTOR KÍNH LÚP (Vector Parameters)
    search_ring_center: [8.0, 8.0]        // Tọa độ tâm thấu kính tròn [cx, cy]
    search_ring_radius: 4.7               // Bán kính đường tròn thấu kính
    search_stroke_width: 1.8              // Độ dày nét viền kính lúp

    // Tọa độ tay cầm 45 độ vát bo tròn nối liền vành kính ra góc ngoài
    search_handle_start: [11.0, 11.0]     // Điểm bắt đầu chân tay cầm [x1, y1]
    search_handle_end: [15.2, 15.2]       // Điểm kết thúc đuôi tay cầm [x2, y2]

    // 2. MÀU SẮC & TRẠNG THÁI TẬP TRUNG (Color & Focus Styling)
    search_color: "#94A3B8FF"             // Màu xám slate thanh lịch (bình thường)
    search_color_focused: "#F1F5F9FF"     // Màu trắng sáng nổi bật (khi nhập tìm kiếm)
    search_antialiasing: 6                // Mật độ khử răng cưa Subpixel (6x6 = 36 mẫu/pixel)
}

// =========================================================================
// HÀM THỰC THI THUẬT TOÁN VẼ BIỂU TƯỢNG TÌM KIẾM (KMI Action)
// Dễ dàng bảo trì, tùy chỉnh tọa độ kính lúp trực tiếp tại file .k
// =========================================================================
action render_search_icon(event) {
    draw.circle(
        state.get("search_ring_center")[0],
        state.get("search_ring_center")[1],
        state.get("search_ring_radius"),
        state.get("search_color"),
        state.get("search_stroke_width")
    )
    draw.line(
        state.get("search_handle_start")[0],
        state.get("search_handle_start")[1],
        state.get("search_handle_end")[0],
        state.get("search_handle_end")[1],
        state.get("search_color"),
        state.get("search_stroke_width")
    )
}
