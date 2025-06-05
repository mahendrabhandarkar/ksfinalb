package com.ks.ksfinalb.service.graphdb;

import com.ks.ksfinalb.repository.GraphDBRepository;
import lombok.RequiredArgsConstructor;
import org.neo4j.graphdb.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    }
}
