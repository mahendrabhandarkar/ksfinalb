package com.ks.ksfinalb.service.graphdb;

import com.ks.ksfinalb.repository.GraphDBRepository;
import com.ks.ksfinalb.security.config.Neo4jConfig;
import lombok.RequiredArgsConstructor;
import org.neo4j.driver.Driver;
import org.neo4j.driver.SessionConfig;
import org.neo4j.graphdb.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class GraphDBService implements IGraphDBService {

    public static final Logger logger = LoggerFactory.getLogger(GraphDBService.class);

    @Autowired
    GraphDBRepository graphDBRepository;

    @Autowired
    GraphDatabaseService graphDB;

    public void doTransaction() {
        Transaction transaction = graphDB.beginTx();
        Node car = transaction.createNode(Label.label("Car"));
        car.setProperty("make", "tesla");
        car.setProperty("model", "model3");

        Node owner = transaction.createNode(Label.label("Person"));
        owner.setProperty("firstName", "test");
        owner.setProperty("lastName", "test2");

        owner.createRelationshipTo(car, RelationshipType.withName("owner"));

        logger.info("Get transactions details from graph db");

        Result res = transaction.execute(
                "MATCH (c:Car) <-[owner]- (p:Person) " +
                        "WHERE c.make = 'tesla'" +
                        "RETURN p.firstName, p.lastName");
        logger.info("Res:::: " + res.resultAsString());

        List result = graphDBRepository.findAll();
        logger.info("Result:::: " + result);

        Neo4jConfig neo4jConfig = new Neo4jConfig();
        Driver driver = neo4jConfig.driver();
        String word = "cat";
        List<Double> embedding = Arrays.asList(1.5, -0.4, 7.2, 19.6, 20.2);
        storeDocumentWithEmbedding(driver, "cat", embedding);
    }

    public void storeDocumentWithEmbedding(Driver driver, String text, List<Double> embedding) {
        /*Neo4jConfig neo4jConfig = new Neo4jConfig();
        try (var session = driver.session(SessionConfig.forDatabase(neo4jConfig.DEFAULT_DATABASE_NAME))) {
            logger.info("CREATE (d:Document {text: $text, embedding: $embedding})",
                    Map.of("text", text, "embedding", embedding));
            session.run("CREATE (d:Document {text: $text, embedding: $embedding})",
                    Map.of("text", text, "embedding", embedding));
        } catch (Exception e) {
            logger.info("TT1::");
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        driver.close();*/

        try {
            Transaction transaction = graphDB.beginTx();
            logger.info("Insert Vector Embeddings");
            transaction.execute("CREATE (d:Document {text: $text, embedding: $embedding})",
                    Map.of("text", text, "embedding", embedding));

            logger.info("Show Stored Embeddings");
            Result res = transaction.execute(
                    "MATCH (d:Document) " +
                            "RETURN d.text AS text, d.embedding AS embedding " +
                            "LIMIT 10 ");
            logger.info("Vector Embeddings:::: " + res.resultAsString());
        } catch (Exception e) {
            logger.info("TT2");
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}