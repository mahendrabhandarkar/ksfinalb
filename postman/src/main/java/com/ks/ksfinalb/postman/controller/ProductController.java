package com.ks.ksfinalb.postman.controller;

import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyClientBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/test")
public class ProductController {
    @GetMapping("/1")
    public ResponseEntity<Integer> getCalc() {
        return ResponseEntity.ok(2);
    }

    @PostMapping("/proxyrequest")
    public Response getProxyRequest() {
        String url = "http://localhost:8080/test/1";
        String req = "{}";
        JerseyClient client = JerseyClientBuilder.createClient();
        WebTarget wt = client.target(url);

        Response externalResponse = wt.request().get();
        String body = externalResponse.readEntity(String.class);
        return Response.status(externalResponse.getStatus()).entity(body).type(externalResponse.getMediaType()).build();
    }
}
