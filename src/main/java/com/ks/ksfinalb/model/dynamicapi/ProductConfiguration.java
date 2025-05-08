package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "di_product_configuration")
public class ProductConfiguration {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_configuration_id")
    private Long productConfigurationId;
    @Column(name="product_id")
    private Integer productId;
    @Column(name="product_service_id")
    private Integer productServiceId;
    @Column(name="referring_product_service_id")
    private Integer referringProductServiceId;

    @ElementCollection
    @CollectionTable(name="di_product_conf_columns", joinColumns = @JoinColumn(name = "product_conf_id"))
    @Column(name = "list_product_conf")
    List<Long> productConfigurableColumns;

    @ElementCollection
    List<ProductConfigurableColumns> productConfigurableColumnsList;

    @Column(name = "api_call")
    String apiCall;
    @Column(name="redirect")
    String redirect;
    @Column(name="batch")
    String batch;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name="display_to_customer")
    Object displayToCustomer;

    @Column(name="step")
    Integer step;
    @Column(name="store_in_db")
    Boolean storeInDb;
    @Column(name = "created_date")
    Timestamp createdDate;
    @Column(name="modified_date")
    Timestamp modifiedDate;
    @Column(name = "created_by")
    String createdBy;
    @Column(name = "modified_by")
    Timestamp modifiedBy;

    @ElementCollection
    @CollectionTable(name = "di_api_config", joinColumns = @JoinColumn(name="api_configuration_id"))
    @Column(name = "list_api_config")
    List<Long> apiConfig;

    @ElementCollection
    List<ApiConfig> apiConfigList;
}
