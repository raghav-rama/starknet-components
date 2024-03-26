#[cfg(test)]
mod tests {
    use starknet_components::ownable::OwnableComponent;
    use starknet_components::interface::IOwnableDispatcher;
    use starknet_components::interface::IOwnableDispatcherTrait;
    use starknet::syscalls::deploy_syscall;
    use starknet::get_caller_address;
    #[test]
    #[available_gas(2_000_000_000)]
    fn test_ownable() {
        let owner: felt252 = get_caller_address().try_into().unwrap();
        let mut calldata = ArrayTrait::new();
        calldata.append(owner);
        let (address0, _) = deploy_syscall(OwnableComponent::TEST_CLASS_HASH.try_into().unwrap(), 0, calldata.span(), false).unwrap();
        let contract0 = IOwnableDispatcher { contract_address: address0 };
        assert_eq!(contract0.owner(), owner.try_into().unwrap());
    }
}