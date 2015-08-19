package sodium;

import haxe.crypto.Base64;
import haxe.io.BytesData;
import haxe.io.Bytes;
import sodium.SodiumWrapper;

@:allow(sodium.SodiumWrapper)
abstract PublicKey(Bytes) to Bytes{
  public function new(b : Bytes) {
    this = b;
  }

  static private function createEmpty() {
    return new PublicKey(Bytes.alloc(SodiumWrapper.box_PUBLICKEYBYTES));
  }

  @:from static public inline function fromBytes(b : Bytes) : PublicKey {
    if (b.length != SodiumWrapper.box_PUBLICKEYBYTES) {
      return null;
    }
    return new PublicKey(b);
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