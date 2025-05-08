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
@Table(name = "di_response_handling")
public class ResponseHandling {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "response_handling_id", nullable = false)
    private Long id;

    @Column(name="dialog_text")
    String dialogText;
    @Column(name="dialog_title")
    String dialogTitle;
    @Column(name="dialog_cancel")
    Boolean dialogCancel;
    @Column(name="dialog_success")
    Boolean dialogSuccess;
    @Column(name="cancel_dialog_text")
    String cancelDialogText;
    @Column(name="success_dialog_text")
    String successDialogText;
    @Column(name="steps_dialog_popup_cancel")
    String stepsDialogPopUpCancel;
    @Column(name="response_handling_options")
    String responseHandlingOptions;
    @Column(name = "redirection_attribute")
    String redirectionAttribute;
    @Column(name="steps_dialog_popup_success")
    String stepsDialogPopUpSuccess;

    @Embedded
    List<OptionalData> optionalData;

}
