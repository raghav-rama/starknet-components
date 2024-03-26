#[starknet::component]
pub mod OwnableComponent {
    //use openzeppelin::introspection::src5::SRC5Component::InternalTrait as SRC5InternalTrait;
    //use openzeppelin::introspection::src5::SRC5Component;
    use starknet::ContractAddress;
    use starknet_components::interface;

    #[storage]
    struct Storage {
        owner: ContractAddress,
    }

    #[embeddable_as(Ownable)]
    impl OwnableImpl<
        TContractState, +HasComponent<TContractState>
    > of interface::IOwnable<ComponentState<TContractState>> {
        fn owner(self: @ComponentState<TContractState>) -> ContractAddress {
            self.owner.read()
        }
    }
}

