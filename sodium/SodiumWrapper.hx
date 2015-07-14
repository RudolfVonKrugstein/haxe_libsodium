package sodium;

import js.html.Uint8Array;
class SodiumWrapper {
  /** Convinience wrapper functions*/

  // Memlimit/opslimit for passwordhash
  static inline private var memlimit : Int = 16 * 1024 * 1024;
  static inline private var opslimit : Int = 1024 * 512;
  static public function crypto_pwhash(password :String, salt : Uint8Array, keyLength : Int) : Uint8Array {
    return Sodium.crypto_pwhash_scryptsalsa208sha256(password, salt, opslimit, memlimit, keyLength);
  }

  static public function crypto_pwhash_zero_salt(password :String, keyLength : Int) : Uint8Array {
    var salt = new Uint8Array([for (i in 0...Sodium.crypto_pwhash_scryptsalsa208sha256_SALTBYTES) 0]);
    return Sodium.crypto_pwhash_scryptsalsa208sha256(password, salt, opslimit, memlimit, keyLength);
  }

  // Encrypt/decrypt with secretkey WITHOUT nonce
  static public function crypto_secretbox_easy_no_nonce(message : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array {
    var nonce = new Uint8Array([for (i in 0...Sodium.crypto_secretbox_NONCEBYTES) 0]);
    return Sodium.crypto_secretbox_easy(message, nonce, key, outputFormat);
  }
  static public function crypto_secretbox_open_easy_no_nonce(cipher : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array {
    var nonce = new Uint8Array([for (i in 0...Sodium.crypto_secretbox_NONCEBYTES) 0]);
    return Sodium.crypto_secretbox_open_easy(cipher, nonce, key, outputFormat);
  }
}