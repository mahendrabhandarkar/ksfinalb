package com.ks.ksfinalb.repository;

import com.ks.ksfinalb.model.stt.UrlAccessRule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UrlAccessRuleRepository extends JpaRepository<UrlAccessRule, Long> {
    @Override
    List<UrlAccessRule> findAll();
}
