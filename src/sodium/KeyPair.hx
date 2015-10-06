package sodium;

import haxe.crypto.Base64;
import haxe.io.Bytes;

class KeyPair {
  public var secretKey : SecretKey;
  public var publicKey : PublicKey;

  public function new(secretKey : SecretKey, publicKey : PublicKey) {
    this.secretKey = secretKey;
    this.publicKey = publicKey;
  }

  public inline function getAsBytes() {
     var res = Bytes.alloc(SodiumWrapper.box_PUBLICKEYBYTES + SodiumWrapper.box_SECRETKEYBYTES);
     res.blit(0, secretKey, 0, SodiumWrapper.box_SECRETKEYBYTES);
     res.blit(SodiumWrapper.box_SECRETKEYBYTES, publicKey, 0, SodiumWrapper.box_PUBLICKEYBYTES);
     return res;
  }

  static public inline function fromBytes(b : Bytes) : KeyPair {
    if (b.length != SodiumWrapper.box_PUBLICKEYBYTES + SodiumWrapper.box_SECRETKEYBYTES) {
      return null;
    }
    var secretKeyBytes = Bytes.alloc(SodiumWrapper.box_SECRETKEYBYTES);
    var publicKeyBytes = Bytes.alloc(SodiumWrapper.box_PUBLICKEYBYTES);
    secretKeyBytes.blit(0,b,0,SodiumWrapper.box_SECRETKEYBYTES);
    publicKeyBytes.blit(0,b,SodiumWrapper.box_SECRETKEYBYTES, SodiumWrapper.box_SECRETKEYBYTES + SodiumWrapper.box_PUBLICKEYBYTES);

    return new KeyPair(secretKeyBytes, publicKeyBytes);
  }

  @:from static public inline function fromBase64(b64 : String) : KeyPair {
    return fromBytes(Base64.decode(b64));
  }

  public function toBase64() : String {
    return Base64.encode(this.getAsBytes());
  }
}