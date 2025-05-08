package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Embeddable
public class ServiceTimer {

    String timeLimit;
    String timerText;
    String runsTillTimer;
    String timerFailureFlow;
    String timerSuccessFlow;
    String timerDisplayOption;
}
