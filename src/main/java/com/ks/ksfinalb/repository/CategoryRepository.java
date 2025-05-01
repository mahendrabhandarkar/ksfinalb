package com.ks.ksfinalb.repository;

import com.ks.ksfinalb.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
  Category findByName(String name);

  boolean existsByName(String name);
}
