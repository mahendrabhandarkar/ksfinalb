package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "di_step_details")
public class StepDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "step_details_id", nullable = false)
    private Long id;
    @Column(name = "layout")
    String layout;
    @Column(name = "step_title")
    String stepTitle;
    @Column(name = "sub_layout")
    String subLayout;
    @Column(name = "list_option")
    String listOption;
    @Column(name = "failure_flow", insertable = false, updatable = false)
    String failureFlow;
    @Column(name = "multi_layout")
    String multiLayout;
    @Column(name = "success_flow", insertable = false, updatable = false)
    String successFlow;
    @Column(name = "layout_axis")
    String layoutAxis;
    @Column(name = "previous_flow")
    String previousFlow;
    @Column(name = "search_option")
    String searchOption;
    @Column(name = "action_on_click")
    Boolean actionOnClick;
    @Column(name = "add_button_list")
    Boolean addButtonList;
    @Column(name = "biometric_type")
    String biometricType;
    @Column(name = "list_condition")
    String listCondition;
    @Column(name = "dont_show_button")
    Boolean dontShowButton;
    @Column(name = "redirection_url")
    String redirectionUrl;
    @Column(name = "hide_faq")
    Boolean hideFaq;
    @Column(name = "hide_web_image")
    Boolean hideWebImage;
    @Column(name = "limit")
    String limit;
    @Column(name = "has_optional_flow")
    Boolean hasOptionalFlow;
    @Column(name = "show_dialog_on_load")
    Boolean showDialogOnLoad;
    @Column(name = "skip_error")
    Boolean skipError;
    @Column(name = "submit_button_text")
    String submitButtonText;
    @Column(name = "timer_confirmation")
    Boolean timerConfirmation;
    @Column(name = "redirection_attribute")
    String redirectionAttribute;
    @Column(name = "service_timer")
    ServiceTimer timer;
    @Column(name = "dynamic_step_title")
    String dynamicStepTitle;
    @Embedded
    @Column(name = "list_button_options")
    List<ButtonOptions> buttonOptions;
    @Column(name = "multi_layout_button_options_array")
    List<String> multiLayoutButtonOptionsArray;
    @Column(name = "clear_cache_steps_array")
    List<String> clearCacheStepsArray;
    @Column(name = "tabs_layout_options")
    List<String> tabsLayoutOptions;
    @Column(name = "list_item_type")
    String listItemType;
}
