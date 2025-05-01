package com.ks.ksfinalb.repository;

import com.ks.ksfinalb.model.CartItem;
import com.ks.ksfinalb.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    void deleteAllByCartId(Long id);
    List<CartItem> findByProductId(Long productId);
}
