package com.ks.ksfinalb.service.order;

import com.ks.ksfinalb.dto.OrderDto;
import com.ks.ksfinalb.model.Order;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface IOrderService {
    Order placeOrder(Long userId);
    OrderDto getOrder(Long orderId);
    List<OrderDto> getUserOrders(Long userId);

    OrderDto convertToDto(Order order);
}
