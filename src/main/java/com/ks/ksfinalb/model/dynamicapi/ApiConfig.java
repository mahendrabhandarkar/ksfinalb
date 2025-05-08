package com.ks.ksfinalb.model.dynamicapi;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "di_api_config")
public class ApiConfig {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "api_configuration_id")
    private Long apiConfigurationId;
    @Column(name = "api_name")
    String apiName;
    @Column(name = "authentication_type")
    String authenticationType;
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "username")
    Object username;
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "password")
    Object password;
    @Column(name = "access_token")
    String accessToken;
    @Column(name = "token_endpoint")
    String tokenEndpoint;
    @Column(name = "endpoint_name")
    String endpointName;
    @Column(name = "use_as")
    String useAs;
    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "data_type")
    Object dataType;
    @Column(name = "api_method")
    String apiMethod;
    @Column(name = "app_endpoint_url")
    String apiEndpointUrl;
    @Column(name = "headers")
    List<String> headers;
    @Column(name = "parameters")
    List<String> parameters;
    @Column(name = "accept")
    String accept;
    @Column(name = "content_type")
    String contentType;
    @Embedded
    ErrorHandling errorHandling;
}
