# Create a CLTV script with a timestamp of 1495584032 and public key below:
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
#!/bin/bash

# Create a CLTV (CheckLockTimeVerify) script with a timestamp of 1495584032 and the public key below
public_key=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

# Compute HASH160 (SHA256 followed by RIPEMD160) of the public key
pubkey_hash=$(echo -n "$public_key" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 20)

# Timestamp 1495584032 = 0x5924CD20, converted to little-endian = 20cd2459
timestamp_little_endian="20cd2459"

# Construct and output the CLTV script in hex:
# 04          = push 4 bytes (length of timestamp)
# <timestamp> = CLTV lock time in little-endian
# b1          = OP_CHECKLOCKTIMEVERIFY
# 75          = OP_DROP
# 76          = OP_DUP
# a9          = OP_HASH160
# 14          = push 20 bytes (length of pubkey hash)
# <pubkeyhash>= HASH160 of the public key
# 88          = OP_EQUALVERIFY
# ac          = OP_CHECKSIG
echo "04${timestamp_little_endian}b17576a914${pubkey_hash}88ac"