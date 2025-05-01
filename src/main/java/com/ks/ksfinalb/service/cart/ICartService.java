package com.ks.ksfinalb.service.cart;

import com.ks.ksfinalb.dto.CartDto;
import com.ks.ksfinalb.model.Cart;
import com.ks.ksfinalb.model.User;

import java.math.BigDecimal;

public interface ICartService {
    Cart getCart(Long id);
    void clearCart(Long id);
    BigDecimal getTotalPrice(Long id);

    Cart initializeNewCart(User user);

    Cart getCartByUserId(Long userId);

    CartDto convertToDto(Cart cart);
}
