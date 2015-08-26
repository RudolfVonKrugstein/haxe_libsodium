#include "sodium_haxe.h"
#include <sodium.h>

//const static int crypto_secretbox_NONCEBYTES = 0;
//const static int crypto_secretbox_KEYBYTES = 0;
//const static int crypto_secretbox_scryptsalsa208sha256_SALTBYTES = 0;

int Sodium::crypto_pwhash_scryptsalsa208sha256(const char* password, Array<unsigned char>& salt, int opslimit, int memlimit, int keylength, Array<unsigned char>& result_buffer) {
  return crypto_pwhash_scryptsalsa208sha256(result_buffer
                                       unsigned long long outlen,
                                       const char * const passwd,
                                       unsigned long long passwdlen,
                                       const unsigned char * const salt,
                                       unsigned long long opslimit,
                                       size_t memlimit);
}
// Generic hash
void Sodium::crypto_generichash(int hash_length, const char* message, Array<unsigned char>& key, Array<unsigned char>& result_buffer) {}

//Random bytes
void Sodium::randombytes_buf(int lenght, Array<unsigned char>& result_buffer) {}

// Public key encryption
void Sodium::crypto_box_keypair(Array<unsigned char>& privateKeyBuffer, Array<unsigned char>& publicKeyBuffer) {}
void Sodium::crypto_box_seal(Array<unsigned char>& message, Array<unsigned char>& recipient_pk, Array<unsigned char>& result_buffer) {}
void Sodium::crypto_box_seal_open(Array<unsigned char>& cipher, Array<unsigned char>& my_pk, Array<unsigned char>& my_sk, Array<unsigned char>& result_buffer) {}

void Sodium::crypto_secretbox_easy(Array<unsigned char>& message, Array<unsigned char>& nonce, Array<unsigned char>& key, Array<unsigned char>& result_buffer) {}
void Sodium::crypto_secretbox_open_easy(Array<unsigned char>& cipher, Array<unsigned char>& nonce, Array<unsigned char>& key, Array<unsigned char>& result_buffer) {}
