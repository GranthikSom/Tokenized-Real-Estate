module MyModule::TokenizedRealEstate {
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a real estate property.
    struct Property has store, key {
        total_raised: u64,  // Total funds invested
        price: u64,         // Property price
    }

    /// List a real estate property with a price.
    public fun list_property(owner: &signer, price: u64) {
        let property = Property {
            total_raised: 0,
            price,
        };
        move_to(owner, property);
    }

    /// Investors contribute funds to a listed property.
    public fun invest(investor: &signer, property_owner: address, amount: u64) acquires Property {
        let property = borrow_global_mut<Property>(property_owner);
        let investment = coin::withdraw<AptosCoin>(investor, amount);
        coin::deposit<AptosCoin>(property_owner, investment);
        property.total_raised = property.total_raised + amount;
    }
}