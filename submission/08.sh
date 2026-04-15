# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
#!/bin/bash
public_key=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

# Compute HASH160 (SHA256 followed by RIPEMD160) of the public key
pubkey_hash=$(echo -n "$public_key" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 20)

# 6 months = 180 days = 15,552,000 seconds
# In 512-second units: 15552000 / 512 = 30375
# With type flag (bit 22): 30375 | 0x400000 = 4224679 = 0x4076A7
# Converted to little-endian (3 bytes): a77640
sequence_little_endian="a77640"

# Construct and output the time-based CSV script in hex:
# 03          = push 3 bytes (length of sequence value)
# <sequence>  = relative lock time (6 months in 512-second units) in little-endian
# b2          = OP_CHECKSEQUENCEVERIFY
# 75          = OP_DROP
# 76          = OP_DUP
# a9          = OP_HASH160
# 14          = push 20 bytes (length of pubkey hash)
# <pubkeyhash>= HASH160 of the public key
# 88          = OP_EQUALVERIFY
# ac          = OP_CHECKSIG
echo "03${sequence_little_endian}b27576a914${pubkey_hash}88ac"