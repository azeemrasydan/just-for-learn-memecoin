package com.trading.memecoin.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.trading.memecoin.domain.Coin;

public interface CoinRepository extends JpaRepository<Coin, Long> {
}
