package com.ks.ksfinalb.security.config;

import org.neo4j.dbms.api.DatabaseManagementService;
import org.neo4j.dbms.api.DatabaseManagementServiceBuilder;
import org.neo4j.graphdb.GraphDatabaseService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;

@Configuration
public class Neo4jConfig {
    @Bean(destroyMethod = "shutdown")
    public DatabaseManagementService databaseManagementService() {
        return new DatabaseManagementServiceBuilder(new File("target/neo4j-db").toPath()).build();
    }

    @Bean
    public GraphDatabaseService graphDatabaseService(DatabaseManagementService managementService) {
        return managementService.database("neo4j");
    }
}
