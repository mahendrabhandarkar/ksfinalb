package com.ks.ksfinalb.postman.controller;

import com.ks.ksfinalb.postman.model.MyRequestModel;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.glassfish.jersey.client.JerseyClient;
import org.glassfish.jersey.client.JerseyClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/test")
public class ProductController {

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @GetMapping("/1")
    public ResponseEntity<Integer> getCalc() {
        return ResponseEntity.ok(2);
    }

    @PostMapping("/2")
    public ResponseEntity<Integer> getCalc2(@RequestBody String req) {
        logger.info("POST METHOD Request:::" + req);
        return ResponseEntity.ok(3);
    }

    @PostMapping("/proxyrequest")
    public Response getProxyRequest(@RequestBody MyRequestModel myRequestModel) {
        String url = myRequestModel.getUrl();
        if (url == null || url.trim().isEmpty()) {
            url = "http://localhost:8080/test/1"; // Default if empty
        }

        Client client = JerseyClientBuilder.createClient();
        WebTarget wt = client.target(url);

        // Add headers if present
        Invocation.Builder builder = wt.request();
        if (myRequestModel.getHeaders() != null) {
            for (Map.Entry<String, String> entry : myRequestModel.getHeaders().entrySet()) {
                builder = builder.header(entry.getKey(), entry.getValue());
            }
        }

        Response externalResponse;
        String method = myRequestModel.getMethod() != null ? myRequestModel.getMethod().toUpperCase() : "GET";
        String body = myRequestModel.getBody() != null ? myRequestModel.getBody() : "{}";
        logger.info("Request Parameters:::" + myRequestModel);
        logger.info("RequestBody:::" + method);
        switch (method) {
            case "POST":
                externalResponse = builder.post(Entity.entity(body, MediaType.APPLICATION_JSON));
                break;
            case "PUT":
                externalResponse = builder.put(Entity.entity(body, MediaType.APPLICATION_JSON));
                break;
            case "DELETE":
                externalResponse = builder.delete();
                break;
            case "PATCH":
                // Jersey client does not directly support PATCH, but you can use .method("PATCH", ...)
                externalResponse = builder.method("PATCH", Entity.entity(body, MediaType.APPLICATION_JSON));
                break;
            case "GET":
            default:
                externalResponse = builder.get();
                break;
        }

        String responseBody = externalResponse.readEntity(String.class);
        logger.info("ResponseBody:::" + responseBody);
        return Response.status(externalResponse.getStatus())
                .entity(responseBody)
                .type(externalResponse.getMediaType())
                .build();
    }
}
