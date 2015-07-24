package sodium;

import haxe.io.Bytes;
#if js
import js.html.Uint8Array;

@:final @:native("sodium")
private extern class Sodium {

  // Password hash
  static public function crypto_pwhash_scryptsalsa208sha256(password : String, salt : Uint8Array, opslimit : Int, memlimit : Int, keylength : Int, outputformat : String = 'uint8array') : Uint8Array;

  // Generic hash
  static public function  crypto_generichash(hash_length : Int, message : String, key : Uint8Array = null, outputFormat : String = 'uint8array') : Uint8Array;

  //Random bytes
  static public function randombytes_buf(lenght : Int) : Uint8Array;

  // Public key encryption
  static public function crypto_box_keypair() : {keyType : String, privateKey : Uint8Array, publicKey : Uint8Array};
  static public function crypto_box_seal(message : Uint8Array, recipient_ok : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;
  static public function crypto_box_seal_open(cipher : Uint8Array, my_pk : Uint8Array, my_sk : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;

  // Secret key encryption
  static public var crypto_secretbox_NONCEBYTES : Int;
  static public var crypto_secretbox_KEYBYTES : Int;
  static public var crypto_pwhash_scryptsalsa208sha256_SALTBYTES : Int;
  static public function crypto_secretbox_easy(message : Uint8Array, nonce : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;
  static public function crypto_secretbox_open_easy(cipher : Uint8Array, nonce : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;

  //helper functions
  static public function from_base64(str : String) : Uint8Array;
  static public function to_base64(a : Uint8Array) : String;
}

class SodiumWrapper {
  /** Convinience wrapper functions*/
  static public var crypto_secretbox_NONCEBYTES : Int = Sodium.crypto_secretbox_NONCEBYTES;
  static public var crypto_secretbox_KEYBYTES : Int = Sodium.crypto_secretbox_KEYBYTES;
  static public var crypto_pwhash_SALTBYTES : Int = Sodium.crypto_pwhash_scryptsalsa208sha256_SALTBYTES;

  // Memlimit/opslimit for passwordhash
  static inline private var memlimit : Int = 16 * 1024 * 1024;
  static inline private var opslimit : Int = 1024 * 512;
  static public function crypto_pwhash(password :String, salt : Bytes, keyLength : Int) : Bytes {
    return Bytes.ofData(Sodium.crypto_pwhash_scryptsalsa208sha256(password, new Uint8Array(salt.getData()), opslimit, memlimit, keyLength).buffer);
  }

  // Generic hash
  static public function  crypto_generichash(hash_length : Int, message : String, key : Bytes = null) : Bytes {
    var uKey = (key == null)?null:new Uint8Array(key.getData());
    return Bytes.ofData(Sodium.crypto_generichash(hash_length, message, uKey).buffer);
  }

  // Public key encryption
  static public function crypto_box_keypair() : {keyType : String, privateKey : Bytes, publicKey : Bytes} {
    var tmp = Sodium.crypto_box_keypair();
    return {keyType : tmp.keyType, privateKey : Bytes.ofData(tmp.privateKey.buffer), publicKey : Bytes.ofData(tmp.publicKey.buffer)};
  }

  static public function crypto_box_seal(message : Bytes, recipient_pk : Bytes) : Bytes {
    return Bytes.ofData(Sodium.crypto_box_seal(new Uint8Array(message.getData()),new Uint8Array(recipient_pk.getData())).buffer);
  }

  static public function crypto_box_seal_open(cipher : Bytes, my_pk : Bytes, my_sk : Bytes) : Bytes {
    return Bytes.ofData(Sodium.crypto_box_seal_open(new Uint8Array(cipher.getData()), new Uint8Array(my_pk.getData()), new Uint8Array(my_sk.getData())).buffer);
  }

  //Random bytes
  static public function randombytes_buf(length : Int) : Bytes {
    return Bytes.ofData(Sodium.randombytes_buf(length).buffer);
  }

  static public function crypto_pwhash_zero_salt(password :String, keyLength : Int) : Bytes {
    var salt = new Uint8Array([for (i in 0...Sodium.crypto_pwhash_scryptsalsa208sha256_SALTBYTES) 0]);
    return Bytes.ofData(Sodium.crypto_pwhash_scryptsalsa208sha256(password, salt, opslimit, memlimit, keyLength).buffer);
  }

  // Encrypt/decrypt with secretkey WITHOUT nonce
  static public function crypto_secretbox_easy_no_nonce(message : Bytes, key : Bytes) {
    var nonce = new Uint8Array([for (i in 0...Sodium.crypto_secretbox_NONCEBYTES) 0]);
    return Bytes.ofData(Sodium.crypto_secretbox_easy(new Uint8Array(message.getData()), nonce, new Uint8Array(key.getData())).buffer);
  }
  static public function crypto_secretbox_open_easy_no_nonce(cipher : Bytes, key : Bytes) : Bytes {
    var nonce = new Uint8Array([for (i in 0...Sodium.crypto_secretbox_NONCEBYTES) 0]);
    return Bytes.ofData(Sodium.crypto_secretbox_open_easy(new Uint8Array(cipher.getData()), nonce, new Uint8Array(key.getData())).buffer);
  }
}
#end
#if cpp
class SodiumWrapper {
/** Convinience wrapper functions*/
  static public var crypto_secretbox_NONCEBYTES : Int = 0;
  static public var crypto_secretbox_KEYBYTES : Int = 0;
  static public var crypto_pwhash_SALTBYTES : Int = 0;

// Memlimit/opslimit for passwordhash
  static inline private var memlimit : Int = 16 * 1024 * 1024;
  static inline private var opslimit : Int = 1024 * 512;
  static public function crypto_pwhash(password :String, salt : Bytes, keyLength : Int) : Bytes {
    return Bytes.alloc(5);
  }

// Generic hash
  static public function  crypto_generichash(hash_length : Int, message : String, key : Bytes = null) : Bytes {
    return Bytes.alloc(5);
  }

// Public key encryption
  static public function crypto_box_keypair() : {keyType : String, privateKey : Bytes, publicKey : Bytes} {
    return {keyType : tmp.keyType, privateKey : Bytes.alloc(0), publicKey : Bytes.alloc(0)};
  }

  static public function crypto_box_seal(message : Bytes, recipient_pk : Bytes) : Bytes {
    return Bytes.alloc(0);
  }

  static public function crypto_box_seal_open(cipher : Bytes, my_pk : Bytes, my_sk : Bytes) : Bytes {
    return Bytes.alloc(0);
  }

//Random bytes
  static public function randombytes_buf(length : Int) : Bytes {
    return Bytes.alloc(0);
  }

  static public function crypto_pwhash_zero_salt(password :String, keyLength : Int) : Bytes {
    return Bytes.alloc(0);
  }

// Encrypt/decrypt with secretkey WITHOUT nonce
  static public function crypto_secretbox_easy_no_nonce(message : Bytes, key : Bytes) {
    return Bytes.alloc(0);
  }
  static public function crypto_secretbox_open_easy_no_nonce(cipher : Bytes, key : Bytes) : Bytes {
    return Bytes.alloc(0);
  }
}
#end
