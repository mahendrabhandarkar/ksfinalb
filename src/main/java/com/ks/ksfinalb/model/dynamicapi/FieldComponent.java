package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "di_field_component")
public class FieldComponent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "field_id")
    private Long id;
    @Column(name = "field")
    String field;
    @Column(name = "reg_ex")
    String regEx;
    @Column(name = "table")
    String table;
    @Column(name = "editable")
    Boolean editable;
    @Column(name = "link_text")
    String linkText;
    @Column(name = "link_type")
    String linkType;
    @Column(name = "max_value")
    String maxValue;
    @Column(name = "min_value")
    String minValue;
    @Column(name = "text_size")
    String textSize;
    @Column(name = "condition")
    String condition;
    @Column(name = "field_name")
    String fieldName;
    @Column(name = "form_field")
    String formField;
    @Column(name = "mandatory")
    Boolean mandatory;
    @Column(name = "mask_input")
    String maskInput;
    @Column(name = "timer_text")
    String timerText;
    @Column(name = "action_step")
    String actionStep;
    @Column(name = "text_colour")
    String textColour;
    @Column(name = "timer_limit")
    String timerLimit;
    @Column(name = "validation")
    String validation;
    @Column(name = "calculation")
    String calculation;
    @Column(name = "display_name")
    String displayName;
    @Column(name = "dropdownkey")
    String dropdownKey;
    @Column(name = "dynamic_list")
    String dynamicList;
    @Column(name = "field_length")
    String fieldLength;
    @Column(name = "image_option")
    String imageOption;
    @Column(name = "data_set_value")
    String dataSetValue;
    @Column(name = "symbol")
    String symbol;
    @Column(name = "dynamic_reg_ex")
    String dynamicRegEx;
    @Column(name = "text_position")
    String textPosition;
    @Column(name = "chip_text_color")
    String chipTextColor;
    @Column(name = "dropdown_value")
    String dropdownValue;
    @Column(name = "text_hierarchy")
    String textHierarchy;
    @Column(name = "text_transform")
    String textTransform;
    @Column(name = "visible_to_user")
    Boolean visibleToUser;
    @Column(name = "dynamic_field_id")
    String dynamicFieldId;
    @Column(name = "is_dynamic_array")
    Boolean isDynamicArray;
    @Column(name = "is_encrypted")
    Boolean isEncrypted;
    @Column(name = "dropdown_item_type")
    String dropdownItemType;
    @Column(name = "dynamic_validation")
    String dynamicValidation;
    @Column(name = "condition_rendering")
    Boolean conditionalRendering;
    @Column(name = "group_id")
    String groupId;
    @Column(name = "label_to_textbox")
    String labelToTextbox;
}
