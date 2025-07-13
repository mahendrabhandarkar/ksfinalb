package com.ks.ksfinalb.model.sttandurlaccessrule;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;

@Data
@Entity
@Table(name="tbl_access_module_menu")
public class AccessModuleMenu implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="menu_id", nullable=false)
    private Long menuId;

    @Column(name="menu_name", nullable = false, length = 255)
    private String menuName;

    @Column(name="menu_display_name", nullable = false, length = 255)
    private String menuDisplayName;

    @Column(name="parent_menu_id")
    private Long menuParentId;

    @Column(name="action_id")
    private Long actionId;

    @Column(name="is_menu")
    private Boolean isMenu;


}
