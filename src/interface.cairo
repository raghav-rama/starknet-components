use starknet::ContractAddress;

#[starknet::interface]
pub trait IOwnable<TContractState> {
    fn owner(self: @TContractState) -> ContractAddress;
    fn set_owner(ref self: TContractState, new_owner: ContractAddress);
    //fn transfer_ownership(ref self: TContractState, new_owner: ContractAddress);
    //fn renounce_ownership(ref self: TContractState);
}

#[starknet::interface]
pub trait IPausable<TContractState> {
    fn paused(self: @TContractState) -> bool;
    fn pause(ref self: TContractState);
    fn unpause(ref self: TContractState);
}

#[starknet::interface]
pub trait IOwnableCounter<TContractState> {
    fn get(self: @TContractState) -> u32;
    fn set(ref self: TContractState, value: u32);
}
