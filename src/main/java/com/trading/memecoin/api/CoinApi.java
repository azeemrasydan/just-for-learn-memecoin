package com.trading.memecoin.api;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.trading.memecoin.domain.Coin;
import com.trading.memecoin.repository.CoinRepository;

@RestController
@RequestMapping("/api/coins")
public class CoinApi {

    private final CoinRepository repo;

    public CoinApi(CoinRepository repo) {
        this.repo = repo;
    }

    @GetMapping
    public List<Coin> all() {
        return repo.findAll();
    }

    @PostMapping
    public Coin create(@RequestBody Coin coin) {
        return repo.save(coin);
    }
}
