package sodium;

import js.html.Uint8Array;

@:final @:native("sodium")
extern class Sodium {

  // Password hash
  static public function crypto_pwhash_scryptsalsa208sha256(password : String, salt : Uint8Array, opslimit : Int, memlimit : Int, keylength : Int, outputformat : String = 'uint8array') : Uint8Array;

  //Random bytes
  static public function randombytes_buf(lenght : Int) : Uint8Array;

  // Public key encryption
  static public function crypto_box_keypair() : {keyType : String, privateKey : Uint8Array, publicKey : Uint8Array};
  static public function crypto_box_seal(message : Uint8Array, recipient_ok : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;
  static public function crypto_box_seal_open(cipher : Uint8Array, my_pk : Uint8Array, my_sk : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;

  // Secret key encryption
  static public var crypto_secretbox_NONCEBYTES : Int;
  static public var crypto_secretbox_KEYBYTES : Int;
  static public function crypto_secretbox_easy(message : Uint8Array, nonce : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;
  static public function crypto_secretbox_open_easy(cipher : Uint8Array, nonce : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;

  //helper functions
  static public function from_base64(str : String) : Uint8Array;
  static public function to_base64(a : Uint8Array) : String;
}