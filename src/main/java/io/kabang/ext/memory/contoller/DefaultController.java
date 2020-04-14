package io.kabang.ext.memory.contoller;

import io.kabang.ext.memory.service.DefaultService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DefaultController {

    private final DefaultService service;

    public DefaultController(DefaultService service) {
        this.service = service;
    }

    @GetMapping(path = "/test")
    public ResponseEntity<Void> test() throws Throwable {
        this.service.test();
        return ResponseEntity.ok().build();
    }

}
