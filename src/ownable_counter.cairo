#[starknet::contract]
pub mod OwnableCounter {
    use starknet_components::ownable::OwnableComponent;
    use starknet::{ContractAddress, get_caller_address};
    use starknet_components::interface::IOwnableCounter;
    component!(path: OwnableComponent, storage: ownable, event: OwnableEvent);

    #[abi(embed_v0)]
    impl OwnableImpl = OwnableComponent::Ownable<ContractState>;

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        OwnableEvent: OwnableComponent::Event,
    }
    #[storage]
    struct Storage {
        counter: u32,
        #[substorage(v0)]
        ownable: OwnableComponent::Storage,
    }

    #[abi(embed_v0)]
    impl OwnableCounterImpl of IOwnableCounter<ContractState> {
        fn get(self: @ContractState) -> u32 {
            assert(self.ownable.owner.read() == get_caller_address(), 'Only owner can call this fn');
            self.counter.read()
        }
        fn set(ref self: ContractState, value: u32) {
            assert(self.ownable.owner.read() == get_caller_address(), 'Only owner can call this fn');
            self.counter.write(value);
        }
    }
}
