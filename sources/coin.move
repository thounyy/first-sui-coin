module first_coin::coin {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

struct COIN has drop {}

fun init(witness: COIN, ctx: &mut TxContext) {
    let (treasury_cap, metadata) = coin::create_currency<COIN>(witness, 2, b"COIN", b"First Coin", b"This is my first coin", option::none(), ctx);
    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
}

public fun mint(
    treasury_cap: &mut TreasuryCap<COIN>, amount: u64, ctx: &mut TxContext
): Coin<COIN> {
    coin::mint(treasury_cap, amount, ctx)
}

public entry fun mint_and_transfer(
    treasury_cap: &mut TreasuryCap<COIN>, amount: u64, recipient: address, ctx: &mut TxContext
) {
    coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
}

public entry fun burn(treasury_cap: &mut TreasuryCap<COIN>, coin: Coin<COIN>) {
    coin::burn(treasury_cap, coin);
}
}