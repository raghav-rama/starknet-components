# pip install cairo-lang
from starkware.starknet.public.abi import starknet_keccak

# These are the public interface function signatures
extended_function_selector_signatures_list = [
    'supports_interface(felt252)->E((),())',
    'is_valid_signature(felt252,Array<felt252>)->E((),())',
    '__execute__(Array<(ContractAddress,felt252,Array<felt252>)>)->Array<(@Array<felt252>)>',
    '__validate__(Array<(ContractAddress,felt252,Array<felt252>)>)->felt252',
    '__validate_declare__(felt252)->felt252'
]

def main():
    interface_id = 0x0
    for function_signature in extended_function_selector_signatures_list:
        function_id = starknet_keccak(function_signature.encode())
        interface_id ^= function_id
    print('IAccount ID:')
    print(hex(interface_id))


if __name__ == "__main__":
    main()