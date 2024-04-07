#[cfg(test)]
mod tests {
    use starknet_components::ownable_counter::OwnableCounter;
    use starknet_components::interface::{IOwnableDispatcher, IOwnable, IOwnableDispatcherTrait};
    use starknet::contract_address_const;
    use starknet::syscalls::deploy_syscall;

    #[test]
    #[available_gas(200_000_000)]
    fn test_contract_read() {
        let dispatcher = deploy_contract();
        dispatcher.set_owner(contract_address_const::<0>());
        assert(contract_address_const::<0>() == dispatcher.owner(), 'Some fuck up happened');
    }
    #[test]
    #[available_gas(200_000_000)]
    #[should_panic]
    fn test_contract_read_fail() {
        let dispatcher = deploy_contract();
        dispatcher.set_owner(contract_address_const::<1>());
        assert(contract_address_const::<2>() == dispatcher.owner(), 'Some fuck up happened');
    }
    fn deploy_contract() -> IOwnableDispatcher {
        let mut calldata = ArrayTrait::new();
        let (address0, _) = deploy_syscall(
            OwnableCounter::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        )
            .unwrap();
        let contract0 = IOwnableDispatcher { contract_address: address0 };
        contract0
    }
}
