# Construct a 2-of-3 multisig redeem script (serialized hex) using the following public keys:
# publicKey1=02da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d191
# publicKey2=02bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa3
# publicKey3=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
# The script should follow this pattern: OP_2 <pubkey1> <pubkey2> <pubkey3> OP_3 OP_CHECKMULTISIG
#!/bin/bash

# Construct a 2-of-3 multisig redeem script (serialized hex) using the following public keys
public_key_1=02da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d191
public_key_2=02bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa3
public_key_3=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

# Construct and output the 2-of-3 multisig redeem script in hex:
# 52          = OP_2 (minimum number of required signatures)
# 21          = push 33 bytes (length of each compressed public key)
# <pubkey1>   = first public key
# 21          = push 33 bytes
# <pubkey2>   = second public key
# 21          = push 33 bytes
# <pubkey3>   = third public key
# 53          = OP_3 (total number of public keys)
# ae          = OP_CHECKMULTISIG
echo "5221${public_key_1}21${public_key_2}21${public_key_3}53ae"