package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Embeddable
public class OptionalData {
    @Id
    @Column(name = "optional_id", nullable = false)
    private Long id;

    @Column(name="optional_flow_step")
    String optionalFlowStep;
    @Column(name = "optional_flow_condition")
    String optionalFlowCondition;
}
