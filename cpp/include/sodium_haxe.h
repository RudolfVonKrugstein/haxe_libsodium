#include <hxcpp.h>

class Sodium {
public:
  const static int crypto_secretbox_NONCEBYTES = 0;
  const static int crypto_secretbox_KEYBYTES = 0;
  const static int crypto_secretbox_scryptsalsa208sha256_SALTBYTES = 0;

  static void crypto_pwhash_scryptsalsa208sha256(const char* password, Array<unsigned char>& salt, int opslimit, int memlimit, int keylength, Array<unsigned char>& result_buffer);
  // Generic hash
  static void crypto_generichash(int hash_length, const char* message, Array<unsigned char>& key, Array<unsigned char>& result_buffer);

  //Random bytes
  static void randombytes_buf(int lenght, Array<unsigned char>& result_buffer);

  // Public key encryption
  static void crypto_box_keypair(Array<unsigned char>& privateKeyBuffer, Array<unsigned char>& publicKeyBuffer);
  static void crypto_box_seal(Array<unsigned char>& message, Array<unsigned char>& recipient_pk, Array<unsigned char>& result_buffer);
  static void crypto_box_seal_open(Array<unsigned char>& cipher, Array<unsigned char>& my_pk, Array<unsigned char>& my_sk, Array<unsigned char>& result_buffer);

  static void crypto_secretbox_easy(Array<unsigned char>& message, Array<unsigned char>& nonce, Array<unsigned char>& key, Array<unsigned char>& result_buffer);
  static void crypto_secretbox_open_easy(Array<unsigned char>& cipher, Array<unsigned char>& nonce, Array<unsigned char>& key, Array<unsigned char>& result_buffer);
};
