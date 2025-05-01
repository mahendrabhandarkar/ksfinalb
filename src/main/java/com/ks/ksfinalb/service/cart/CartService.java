package com.ks.ksfinalb.service.cart;

import com.ks.ksfinalb.dto.CartDto;
import com.ks.ksfinalb.exceptions.ResourceNotFoundException;
import com.ks.ksfinalb.model.Cart;
import com.ks.ksfinalb.model.User;
import com.ks.ksfinalb.repository.CartItemRepository;
import com.ks.ksfinalb.repository.CartRepository;
import com.ks.ksfinalb.repository.UserRepository;
import com.ks.ksfinalb.service.product.IProductService;
import com.ks.ksfinalb.service.user.IUserService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicLong;

@Service
@RequiredArgsConstructor
public class CartService implements ICartService{
    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final ModelMapper modelMapper;
    private final IUserService userService;

    @Override
    public Cart getCart(Long cartId) {
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new ResourceNotFoundException("Cart not found"));
        BigDecimal totalAmount = cart.getTotalAmount();
        cart.setTotalAmount(totalAmount);
        return cartRepository.save(cart);
    }


    /*    @Override
    public Cart getCart(Long userId) {
        return Optional.ofNullable(getCartByUserId(userId))
                .map(cart -> {
                    // If the cart exists, return it
                    BigDecimal totalAmount = cart.getTotalAmount();
                    cart.setTotalAmount(totalAmount);
                    return cartRepository.save(cart);
                })
                .orElseGet(() -> {
                    // If the cart does not exist, initialize a new cart
                    User user = Optional.ofNullable(userService.getUserById(userId))
                            .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                    return initializeNewCart(user);
                });
    }*/

    @Transactional
    @Override
    public void clearCart(Long id) {
        Cart cart = getCart(id);
        cartItemRepository.deleteAllByCartId(id);
        cart.clearCart();
        cartRepository.deleteById(id);
    }

    @Override
    public BigDecimal getTotalPrice(Long id) {
        Cart cart = getCart(id);
        return cart.getTotalAmount();
    }


    @Override
    public Cart initializeNewCart(User user) {
        return Optional.ofNullable(getCartByUserId(user.getId()))
                .orElseGet(() -> {
                    Cart cart = new Cart();
                    cart.setUser(user);
                    return cartRepository.save(cart);
                });
    }

  @Override
    public Cart getCartByUserId(Long userId) {
       return cartRepository.findByUserId(userId);
    }

    @Override
    public CartDto convertToDto(Cart cart){
        return modelMapper.map(cart, CartDto.class);
    }
}
