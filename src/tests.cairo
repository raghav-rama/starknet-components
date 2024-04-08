#[cfg(test)]
mod tests {
    use starknet_components::ownable_counter::OwnableCounter;
    use starknet_components::interface::{IOwnableDispatcher, IOwnable, IOwnableDispatcherTrait, IOwnableCounter, IOwnableCounterDispatcher, IOwnableCounterDispatcherTrait};
    use starknet::contract_address_const;
    use starknet::syscalls::deploy_syscall;
    use starknet::testing;

    #[test]
    #[available_gas(200_000_000)]
    fn test_contract_read() {
        let dispatcher = deploy_contract();
        dispatcher.set_owner(contract_address_const::<0>());
        assert(contract_address_const::<0>() == dispatcher.owner(), 'Some fuck up happened');
    }
    #[test]
    #[available_gas(200_000_000)]
    fn test_contract_counter_set() {
        let dispatcher0 = deploy_contract();
        dispatcher0.set_owner(contract_address_const::<0>());
        assert(contract_address_const::<0>() == dispatcher0.owner(), 'Some fuck up happened');
        let dispatcher1 = deploy();
        dispatcher1.set(4);
        assert(dispatcher1.get() == 4, 'Should be 4');
    }
    #[test]
    #[available_gas(200_000_000)]
    fn test_contract_counter_get() {
        let mut state = OwnableCounter::contract_state_for_testing();
        testing::set_caller_address(contract_address_const::<1>());
        state.set_owner(contract_address_const::<1>());
        assert(contract_address_const::<1>() == state.owner(), 'Some fuck up happened');
        state.set(5);
        assert(state.get() == 5, 'Should be 5');

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
    fn deploy() -> IOwnableCounterDispatcher {
        let mut calldata = ArrayTrait::new();
        let (address0, _) = deploy_syscall(
            OwnableCounter::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false
        )
            .unwrap();
        let contract0 = IOwnableCounterDispatcher { contract_address: address0 };
        contract0
    }
}
