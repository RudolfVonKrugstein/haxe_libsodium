package sodium;

import haxe.io.BytesData;
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
#end
#if cpp
typedef ArrayType = BytesData;
typedef UnsignedConstCharStar = cpp.RawConstPointer<haxe.io.BytesData.Unsigned_char__>;
typedef UnsignedCharStar = cpp.RawConstPointer<haxe.io.BytesData.Unsigned_char__>;
@:buildXml("
<target id='haxe'>
<lib name='-lsodium'/>
</target>
<target id='__lib__'>
<lib name='-lsodium'/>
</target>
")
/*@:buildXml("
<files id='haxe'>
<compilerflag value='-lsodium'/>
<compilerflag value='-I../../cpp/include'/>
<file name='../../cpp/sodium_haxe.cpp'/>
</files>
<files id='__lib__'>
<compilerflag value='-lsodium'/>
<compilerflag value='-I../../cpp/include'/>
<file name='../../cpp/sodium_haxe.cpp'/>
</files>
")*/

@:keep class Include{  }

@:structaccess
@:include("sodium.h")
@:native("Sodium")
private extern class Sodium {

  // Password hash
  @:native("crypto_pwhash_scryptsalsa208sha256")
  static public function crypto_pwhash_scryptsalsa208sha256(out : UnsignedCharStar, outlen : Int, passwd : cpp.ConstCharStar, passwdlen : Int, salt : UnsignedConstCharStar, opslimit : Int, memlimit : Int) : Int;

  // Generic hash
  @:native("crypto_generichash")
  static public function crypto_generichash(out : UnsignedCharStar, outlen : Int, input : UnsignedConstCharStar, inlen : Int, key : UnsignedConstCharStar, keylen : Int) : Int;

  //Random bytes
  @:native("randombytes_buf")
  static public function randombytes_buf(bug : UnsignedCharStar, lenght : Int) : Void;

  // Public key encryption
  @:native("crypto_box_keypair")
  static public function crypto_box_keypair(publicKey : UnsignedCharStar, privateKey : UnsignedCharStar) : Void;
  @:native("crypto_box_seal")
  static public function crypto_box_seal(out : UnsignedCharStar, message : UnsignedConstCharStar, message_len : Int, publicKey : UnsignedConstCharStar) : Int;
  @:native("crypto_box_seal_open")
  static public function crypto_box_seal_open(out : UnsignedCharStar, encrypted : UnsignedConstCharStar, encrypted_len : Int, publicKey : UnsignedConstCharStar, privateKey : UnsignedConstCharStar) : Int;

  // Secret key encryption
  @:native("crypto_secretbox_NONCEBYTES")
  static public var crypto_secretbox_NONCEBYTES : Int;
  @:native("crypto_secretbox_KEYBYTES")
  static public var crypto_secretbox_KEYBYTES : Int;
  @:native("crypto_scryptsalsa208sha256_SALTBYTES")
  static public var crypto_pwhash_scryptsalsa208sha256_SALTBYTES : Int;
  @:native("crypto_box_SCECRETKEYBYTES")
  static public var crypto_box_SECRETKEYBYTES : Int;
  @:native("crypto_box_PUBLICBYTES")
  static public var crypto_box_PUBLICKEYBYTES : Int;
  @:native("crypto_box_MACBYTES")
  static public var crypto_box_MACBYTES : Int;

  @:native("crypto_secretbox_easy")
  static public function crypto_secretbox_easy(out : UnsignedCharStar, message : UnsignedConstCharStar, message_len : Int, nonce : UnsignedConstCharStar, key : UnsignedConstCharStar) : Int;
  @:native("crypto_secretbox_open_easy")
  static public function crypto_secretbox_open_easy(out : UnsignedCharStar, encrypted : UnsignedConstCharStar, encrypted_len : Int, nonce : UnsignedConstCharStar, key : UnsignedConstCharStar) : Int;
}
#end

class SodiumWrapper {
  /** Convinience wrapper functions*/
  static public var crypto_secretbox_NONCEBYTES : Int = Sodium.crypto_secretbox_NONCEBYTES;
  static public var crypto_secretbox_KEYBYTES : Int = Sodium.crypto_secretbox_KEYBYTES;
  static public var crypto_pwhash_SALTBYTES : Int = Sodium.crypto_pwhash_scryptsalsa208sha256_SALTBYTES;

  #if cpp
  static private function toUnsignedCharStar(b : Bytes) : UnsignedCharStar {
    return cpp.NativeArray.address(b.getData(), 0).reinterpret().get_raw();
  }
  static private function toUnsignedConstCharStar(b : Bytes) : UnsignedConstCharStar {
    return cpp.NativeArray.address(b.getData(), 0).reinterpret().get_raw();
  }
  #end

  // Memlimit/opslimit for passwordhash
  static inline private var memlimit : Int = 16 * 1024 * 1024;
  static inline private var opslimit : Int = 1024 * 512;
  static public function crypto_pwhash(password :String, salt : Bytes, keyLength : Int) : Bytes {
  #if js
    return Bytes.ofData(Sodium.crypto_pwhash_scryptsalsa208sha256(password, new Uint8Array(salt.getData()), opslimit, memlimit, keyLength).buffer);
  #end
  #if cpp
    var res = Bytes.alloc(keyLength);
    var worked = Sodium.crypto_pwhash_scryptsalsa208sha256(
      toUnsignedCharStar(res),
      keyLength,
      cpp.ConstCharStar.fromString(password),
      password.length,
      toUnsignedConstCharStar(salt),
      opslimit,
      memlimit);
    if (worked != 0) {
      return null;
    }
    return res;
  #end
  }

  // Generic hash
  static public function  crypto_generichash(hash_length : Int, message : String, key : Bytes = null) : Bytes {
    #if js
    var uKey = (key == null)?null:new Uint8Array(key.getData());
    return Bytes.ofData(Sodium.crypto_generichash(hash_length, message, uKey).buffer);
    #end
    #if cpp
    var keyLen = if (key == null) {0;} else {key.length;};
    var uKey = if (key == null) {null;} else {toUnsignedConstCharStar(key);};
    var res = Bytes.alloc(hash_length);
    var worked = Sodium.crypto_generichash(toUnsignedCharStar(res), hash_length, toUnsignedConstCharStar(Bytes.ofString(message)), message.length, uKey, keyLen);
    if (worked != 0) {
      return null;
    }
    return res;
    #end
  }

  // Public key encryption
  static public function crypto_box_keypair() : {privateKey : Bytes, publicKey : Bytes} {
    #if js
    var tmp = Sodium.crypto_box_keypair();
    return {privateKey : Bytes.ofData(tmp.privateKey.buffer), publicKey : Bytes.ofData(tmp.publicKey.buffer)};
    #end
    #if cpp
    var privateKey = Bytes.alloc(Sodium.crypto_box_SECRETKEYBYTES);
    var publicKey = Bytes.alloc(Sodium.crypto_box_PUBLICKEYBYTES);
    Sodium.crypto_box_keypair(toUnsignedCharStar(publicKey), toUnsignedCharStar(privateKey));
    return {privateKey : privateKey, publicKey : publicKey};
    #end
  }

  static public function crypto_box_seal(message : Bytes, recipient_pk : Bytes) : Bytes {
    #if js
    return Bytes.ofData(Sodium.crypto_box_seal(new Uint8Array(message.getData()),new Uint8Array(recipient_pk.getData())).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(Sodium.crypto_box_MACBYTES + message.length);
    Sodium.crypto_box_seal(toUnsignedCharStar(res), toUnsignedConstCharStar(message), message.length, toUnsignedConstCharStar(recipient_pk));
    return res;
    #end
  }

  static public function crypto_box_seal_open(cipher : Bytes, my_pk : Bytes, my_sk : Bytes) : Bytes {
    #if js
    return Bytes.ofData(Sodium.crypto_box_seal_open(new Uint8Array(cipher.getData()), new Uint8Array(my_pk.getData()), new Uint8Array(my_sk.getData())).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(cipher.length - Sodium.crypto_box_MACBYTES);
    Sodium.crypto_box_seal_open(toUnsignedCharStar(res), toUnsignedConstCharStar(cipher), cipher.length, toUnsignedConstCharStar(my_pk), toUnsignedConstCharStar(my_sk));
    return res;
    #end
  }

  //Random bytes
  static public function randombytes_buf(length : Int) : Bytes {
    #if js
    return Bytes.ofData(Sodium.randombytes_buf(length).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(length);
    Sodium.randombytes_buf(toUnsignedCharStar(res), length);
    return res;
    #end
  }

  static public function crypto_pwhash_zero_salt(password :String, keyLength : Int) : Bytes {
    var salt = Bytes.alloc(Sodium.crypto_pwhash_scryptsalsa208sha256_SALTBYTES);
    salt.fill(0,salt.length,0);
    return crypto_pwhash(password, salt, keyLength);
  }

  // Encrypt/decrypt with secretkey
  static public function crypto_secretbox_easy(message : Bytes, nonce : Bytes, key : Bytes) {
    #if js
    return Bytes.ofData(Sodium.crypto_secretbox_easy(new Uint8Array(message.getData()), new Uint8Array(nonce.getData()), new Uint8Array(key.getData())).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(message.length);
    Sodium.crypto_secretbox_easy(toUnsignedCharStar(res), toUnsignedConstCharStar(message), message.length, toUnsignedConstCharStar(nonce), toUnsignedConstCharStar(key));
    return res;
    #end
  }
  static public function crypto_secretbox_open_easy(cipher : Bytes, nonce : Bytes, key : Bytes) : Bytes {
    #if js
    return Bytes.ofData(Sodium.crypto_secretbox_open_easy(new Uint8Array(cipher.getData()), new Uint8Array(nonce), new Uint8Array(key.getData())).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(cipher.length);
    Sodium.crypto_secretbox_open_easy(toUnsignedCharStar(res), toUnsignedConstCharStar(cipher), cipher.length, toUnsignedConstCharStar(nonce), toUnsignedConstCharStar(key));
    return res;
    #end
  }

  // Encrypt/decrypt with secretkey WITHOUT nonce
  static public function crypto_secretbox_easy_no_nonce(message : Bytes, key : Bytes) {
    var nonce = Bytes.alloc(Sodium.crypto_secretbox_NONCEBYTES);
    nonce.fill(0,nonce.length,0);
    return crypto_secretbox_easy(message,nonce,key);
  }
  static public function crypto_secretbox_open_easy_no_nonce(cipher : Bytes, key : Bytes) : Bytes {
    var nonce = Bytes.alloc(Sodium.crypto_secretbox_NONCEBYTES);
    nonce.fill(0,nonce.length,0);
    return crypto_secretbox_open_easy(cipher,nonce,key);
  }
}
