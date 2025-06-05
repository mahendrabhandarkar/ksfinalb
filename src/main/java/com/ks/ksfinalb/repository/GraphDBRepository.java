package com.ks.ksfinalb.repository;

import com.ks.ksfinalb.model.GraphDBModel;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GraphDBRepository extends Neo4jRepository<GraphDBModel, Integer> {

}
