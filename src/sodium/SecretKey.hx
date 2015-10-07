package sodium;

import haxe.crypto.Base64;
import haxe.io.BytesData;
import haxe.io.Bytes;
import sodium.SodiumWrapper;

@:allow(sodium.SodiumWrapper)
abstract SecretKey(Bytes) to Bytes {
  public function new(b : Bytes) {
    this = b;
  }

  static private function createEmpty() {
    return new SecretKey(Bytes.alloc(SodiumWrapper.box_SECRETKEYBYTES));
  }

  @:from static private inline function fromBytes(b : Bytes) : SecretKey {
    if (b.length != SodiumWrapper.box_SECRETKEYBYTES) {
      return null;
    }
    return new SecretKey(b);
  }

   @:from static public inline function fromBase64(b64 : String) : PublicKey {
    return fromBytes(Base64.decode(b64));
  }

  public function toBase64() : String {
    return Base64.encode(this);
  }

  private function getData() : BytesData {
    return this.getData();
  }
}
