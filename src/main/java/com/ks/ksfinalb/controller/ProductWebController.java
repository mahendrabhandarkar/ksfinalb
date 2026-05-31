package com.ks.ksfinalb.controller;

import com.ks.ksfinalb.model.Product;
import com.ks.ksfinalb.model.User;
import com.ks.ksfinalb.model.datatables.DataTableRequest;
import com.ks.ksfinalb.model.datatables.DataTableResponse;
import com.ks.ksfinalb.service.product.IProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Controller
@RequestMapping("/products")
public class ProductWebController {

    private final IProductService productService;

    /*
 Thymeleaf page
*/
    @GetMapping("/page")
    public String productsPage(Model model) {

        User loggedInUser =
                getLoggedInUser();

        model.addAttribute(
                "loggedInUser",
                loggedInUser
        );

        model.addAttribute(
                "totalProducts",
                productService.totalProducts()
        );

        return "datatable_listing";
    }

    /*
     DataTable API
    */
    @PostMapping("/datatable")
    @ResponseBody
    public DataTableResponse<Product> products(
            @RequestBody DataTableRequest request
    ) {

        return productService.getProducts(request);
    }

    private User getLoggedInUser() {

        /*
         Sample only
        */

        User user = new User();

        user.setFirstName("Admin");
        user.setLastName("User");
        return user;
    }
}
