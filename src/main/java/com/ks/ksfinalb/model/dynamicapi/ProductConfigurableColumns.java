package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.List;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "di_product_conf_columns")
public class ProductConfigurableColumns {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_conf_id", nullable = false)
    private Long id;

    @ElementCollection
    @CollectionTable(name="di_field_component", joinColumns = @JoinColumn(name="field_id"))
    @Column(name = "field_component")
    List<Integer> data;

    @ElementCollection
    List<FieldComponent> fieldComponentList;

    @Column(name = "step")
    String step;

    @Column(name = "store")
    @ElementCollection
    List<String> store;

    @Column(name="step_details")
    Integer stepDetails;

 //   StepDetails stepDetailsObj;

    @Column(name="path_parameter")
    List<String> pathParameter;
    @Column(name="query_parameter", insertable = false, updatable = false)
    List<String> queryParameter;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name="request_parameter", insertable = false, updatable = false)
    Map<String, Object> requestParameter;

    @Column(name="query_parameter")
    Integer responseHandling;

 //   ResponseHandling responseHandlingObj;

}
