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
  static public function crypto_secretbox_easy(message : Uint8Array, nonce : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;
  static public function crypto_secretbox_open_easy(cipher : Uint8Array, nonce : Uint8Array, key : Uint8Array, outputFormat : String = 'uint8array') : Uint8Array;

  //helper functions
  static public function from_base64(str : String) : Uint8Array;
  static public function to_base64(a : Uint8Array) : String;

  // Constants
  static public var crypto_secretbox_NONCEBYTES : Int;
  static public var crypto_secretbox_KEYBYTES : Int;
  static public var crypto_secretbox_MACBYTES : Int;
  static public var crypto_pwhash_scryptsalsa208sha256_SALTBYTES : Int;
  static public var crypto_box_SECRETKEYBYTES : Int;
  static public var crypto_box_PUBLICKEYBYTES : Int;
  static public var crypto_box_SEALBYTES : Int;
}
#end
#if cpp
typedef UnsignedConstCharStar = cpp.RawConstPointer<haxe.io.BytesData.Unsigned_char__>;
typedef UnsignedCharStar = cpp.RawPointer<haxe.io.BytesData.Unsigned_char__>;
@:buildXml("
<target id='haxe' unless='static_link'>
<lib name='-lsodium'/>
</target>
<files id='haxe'>
<compilerflag value='-I${haxelib:libsodium}/../dependencies/libsodium-win32/include' if='windows'/>
<compilerflag value='-I${haxelib:libsodium}/../dependencies/libsodium-android-armv7-a/include' if='android'/>
<compilerflag value='-I${haxelib:libsodium}/../dependencies/libsodium-ios/include' if='ios'/>
</files>
<target id='__lib__' unless='static_link'>
<lib name='-lsodium'/>
</target>
<files id='__lib__'>
<compilerflag value='-I${haxelib:libsodium}/../dependencies/libsodium-win32/include' if='windows'/>
<compilerflag value='-I${haxelib:libsodium}/../dependencies/libsodium-android-armv7-a/include' if='android'/>
<compilerflag value='-I${haxelib:libsodium}/../dependencies/libsodium-ios/include' if='ios'/>
</files>
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

@:include("sodium.h")
private extern class Sodium {

  // Initilize
  @:native("sodium_init")
  static public function sodium_init() : Int;
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
  @:native("crypto_secretbox_MACBYTES")
  static public var crypto_secretbox_MACBYTES : Int;
  @:native("crypto_pwhash_scryptsalsa208sha256_SALTBYTES")
  static public var crypto_pwhash_scryptsalsa208sha256_SALTBYTES : Int;
  @:native("crypto_box_SECRETKEYBYTES")
  static public var crypto_box_SECRETKEYBYTES : Int;
  @:native("crypto_box_PUBLICKEYBYTES")
  static public var crypto_box_PUBLICKEYBYTES : Int;
  @:native("crypto_box_MACBYTES")
  static public var crypto_box_MACBYTES : Int;
  @:native("crypto_box_SEALBYTES")
  static public var crypto_box_SEALBYTES : Int;

  @:native("crypto_secretbox_easy")
  static public function crypto_secretbox_easy(out : UnsignedCharStar, message : UnsignedConstCharStar, message_len : Int, nonce : UnsignedConstCharStar, key : UnsignedConstCharStar) : Int;
  @:native("crypto_secretbox_open_easy")
  static public function crypto_secretbox_open_easy(out : UnsignedCharStar, encrypted : UnsignedConstCharStar, encrypted_len : Int, nonce : UnsignedConstCharStar, key : UnsignedConstCharStar) : Int;
}
#end

class SodiumWrapper {

  static public var secretbox_KEYBYTES = Sodium.crypto_secretbox_KEYBYTES;
  static public var pwhash_SALTBYTES = Sodium.crypto_pwhash_scryptsalsa208sha256_SALTBYTES;
  static public var secretbox_NONCEBYTES = Sodium.crypto_secretbox_NONCEBYTES;
  static public var secretbox_MACBYTES = Sodium.crypto_secretbox_MACBYTES;
  static public var box_SECRETKEYBYTES = Sodium.crypto_box_SECRETKEYBYTES;
  static public var box_PUBLICKEYBYTES = Sodium.crypto_box_PUBLICKEYBYTES;
  static public var box_SEALBYTES = Sodium.crypto_box_SEALBYTES;

  static public function init() : Int {
    #if js
    return 0;
    #end
    #if cpp
    return Sodium.sodium_init();
    #end
  }

  /** Convinience wrapper functions*/
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
  static public function pwhash(password :String, salt : Bytes, keyLength : Int) : Bytes {
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
  static public function  generichash(hash_length : Int, message : String, key : Bytes = null) : Bytes {
    #if js
    var uKey = (key == null)?null:new Uint8Array(key.getData());
    return Bytes.ofData(Sodium.crypto_generichash(hash_length, message, uKey).buffer);
    #end
    #if cpp
    var keyLen = if (key == null) {0;} else {key.length;};
    var uKey = if (key == null) {Bytes.alloc(0);} else {key;}
    var res = Bytes.alloc(hash_length);
    var worked = Sodium.crypto_generichash(toUnsignedCharStar(res), hash_length, toUnsignedConstCharStar(Bytes.ofString(message)), message.length, toUnsignedConstCharStar(uKey), keyLen);
    if (worked != 0) {
      return null;
    }
    return res;
    #end
  }

  // Public key encryption
  static public function box_keypair() : {secretKey : SecretKey, publicKey : PublicKey} {
    #if js
    var tmp = Sodium.crypto_box_keypair();
    return {secretKey : SecretKey.fromBytes(Bytes.ofData(tmp.privateKey.buffer)), publicKey : PublicKey.fromBytes(Bytes.ofData(tmp.publicKey.buffer))};
    #end
    #if cpp
    var privateKey = SecretKey.createEmpty();
    var publicKey = PublicKey.createEmpty();
    Sodium.crypto_box_keypair(toUnsignedCharStar(cast publicKey), toUnsignedCharStar(cast privateKey));
    return {secretKey : privateKey, publicKey : publicKey};
    #end
  }

  static public function box_seal(message : Bytes, recipient_pk : PublicKey) : Bytes {
    #if js
    return Bytes.ofData(Sodium.crypto_box_seal(new Uint8Array(message.getData()),new Uint8Array(recipient_pk.getData())).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(Sodium.crypto_box_SEALBYTES + message.length);
    var worked = Sodium.crypto_box_seal(toUnsignedCharStar(res), toUnsignedConstCharStar(message), message.length, toUnsignedConstCharStar(recipient_pk));
    if (worked != 0) {
      return null;
    }
    return res;
    #end
  }

  static public function box_seal_open(cipher : Bytes, my_pk : PublicKey, my_sk : SecretKey) : Bytes {
    if (cipher.length <= Sodium.crypto_box_SEALBYTES) {
      return null;
    }
    #if js
    try {
      return Bytes.ofData(Sodium.crypto_box_seal_open(new Uint8Array(cipher.getData()), new Uint8Array(my_pk.getData()), new Uint8Array(my_sk.getData())).buffer);
    } catch(_ : Dynamic) {
      return null;
    }
    #end
    #if cpp
    var res = Bytes.alloc(cipher.length - Sodium.crypto_box_SEALBYTES);
    var worked = Sodium.crypto_box_seal_open(toUnsignedCharStar(res), toUnsignedConstCharStar(cipher), cipher.length, toUnsignedConstCharStar(my_pk), toUnsignedConstCharStar(my_sk));
    if (worked != 0) {
      return null;
    }
    return res;
    #end
  }

  //Random bytes
  static public function randombytes(length : Int) : Bytes {
    #if js
    return Bytes.ofData(Sodium.randombytes_buf(length).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(length);
    Sodium.randombytes_buf(toUnsignedCharStar(res), length);
    return res;
    #end
  }

  static public function pwhash_zero_salt(password :String, keyLength : Int) : Bytes {
    var salt = Bytes.alloc(Sodium.crypto_pwhash_scryptsalsa208sha256_SALTBYTES);
    salt.fill(0,salt.length,0);
    return pwhash(password, salt, keyLength);
  }

  // Encrypt/decrypt with secretkey
  static public function secretbox_easy(message : Bytes, nonce : Bytes, key : SymmetricKey) {
    #if js
    return Bytes.ofData(Sodium.crypto_secretbox_easy(new Uint8Array(message.getData()), new Uint8Array(nonce.getData()), new Uint8Array(key.getData())).buffer);
    #end
    #if cpp
    var res = Bytes.alloc(message.length + Sodium.crypto_secretbox_MACBYTES);
    var worked = Sodium.crypto_secretbox_easy(toUnsignedCharStar(res), toUnsignedConstCharStar(message), message.length, toUnsignedConstCharStar(nonce), toUnsignedConstCharStar(cast key));
    if (worked != 0) {
      return null;
    }
    return res;
    #end
  }
  static public function secretbox_open_easy(cipher : Bytes, nonce : Bytes, key : SymmetricKey) : Bytes {
    if (cipher.length <= Sodium.crypto_secretbox_MACBYTES) {
      return null;
    }
    #if js
    try {
      return Bytes.ofData(Sodium.crypto_secretbox_open_easy(new Uint8Array(cipher.getData()), new Uint8Array(nonce.getData()), new Uint8Array(key.getData())).buffer);
    } catch(_ : Dynamic) {
      return null;
    }
    #end
    #if cpp
    var res = Bytes.alloc(cipher.length - Sodium.crypto_secretbox_MACBYTES);
    var worked = Sodium.crypto_secretbox_open_easy(toUnsignedCharStar(res), toUnsignedConstCharStar(cipher), cipher.length, toUnsignedConstCharStar(nonce), toUnsignedConstCharStar(key));
    if (worked != 0) {
      return null;
    }
    return res;
    #end
  }

  // Encrypt/decrypt with secretkey WITHOUT nonce
  static public function secretbox_easy_no_nonce(message : Bytes, key : SymmetricKey) {
    var nonce = Bytes.alloc(Sodium.crypto_secretbox_NONCEBYTES);
    nonce.fill(0,nonce.length,0);
    return secretbox_easy(message,nonce,key);
  }
  static public function secretbox_open_easy_no_nonce(cipher : Bytes, key : SymmetricKey) : Bytes {
    var nonce = Bytes.alloc(Sodium.crypto_secretbox_NONCEBYTES);
    nonce.fill(0,nonce.length,0);
    return secretbox_open_easy(cipher,nonce,key);
  }

  static public function make_secretbox_key(password : String) : Bytes {
    return pwhash_zero_salt(password, Sodium.crypto_secretbox_KEYBYTES);
  }
}
