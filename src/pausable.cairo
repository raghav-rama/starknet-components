// So far, we have created a component which can be used to set and get the owner of a contract
// But we didn't do anything with it.
// In this example, we will create a new component which will allow us to pause and unpause the contract.
// We will then use the owner component to only allow the owner to pause and unpause the contract.

#[starknet::component]
pub mod pausable_component {
    use starknet_components::interface;

    #[storage]
    pub struct Storage {
        paused: bool,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        #[flat]
        ContractPaused: (),
    }

    #[embeddable_as(Pausable)]
    impl PausableImpl<
        TContractState, +HasComponent<TContractState>
    > of interface::IPausable<ComponentState<TContractState>> {
        fn paused(self: @ComponentState<TContractState>) -> bool {
            self.storage.paused
        }
        fn pause(ref self: ComponentState<TContractState>) {
            self.paused.write(true);
        }
        fn unpause(ref self: ComponentState<TContractState>) {
            self.paused.write(false);
        }
    }
}
