package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Embeddable
public class ButtonOptions {
    String buttonId;
    String buttonName;
    String failureFlow;
    String successFlow;
    Boolean validation;
}
