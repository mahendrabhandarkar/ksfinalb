package com.ks.ksfinalb.security.config;

import org.neo4j.configuration.GraphDatabaseSettings;
import org.neo4j.dbms.api.DatabaseManagementService;
import org.neo4j.dbms.api.DatabaseManagementServiceBuilder;
import org.neo4j.graphdb.GraphDatabaseService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.time.Duration;

@Configuration
public class Neo4jConfig {
    private final static String DEFAULT_DATABASE_NAME = new String("neo4j");

    @Bean(destroyMethod = "shutdown")
    public DatabaseManagementService databaseManagementService() {
        return new DatabaseManagementServiceBuilder(new File("target/neo4j-db").toPath())
                .setConfig(GraphDatabaseSettings.transaction_timeout, Duration.ofSeconds(60))
                .setConfig(GraphDatabaseSettings.preallocate_logical_logs, true)
                .build();
    }

    @Bean
    public GraphDatabaseService graphDatabaseService(DatabaseManagementService managementService) {
        return managementService.database(DEFAULT_DATABASE_NAME);
    }
}
