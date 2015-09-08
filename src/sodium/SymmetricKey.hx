package sodium;

import haxe.crypto.Base64;
import haxe.io.BytesData;
import haxe.io.Bytes;
import sodium.SodiumWrapper;

@:allow(sodium.SodiumWrapper)
abstract SymmetricKey(Bytes) to Bytes {
  public function new(b : Bytes) {
    this = b;
  }

  static private function createEmpty() {
    return new SymmetricKey(Bytes.alloc(SodiumWrapper.secretbox_KEYBYTES));
  }

  @:from static private inline function fromBytes(b : Bytes) : SymmetricKey {
    if (b.length != SodiumWrapper.secretbox_KEYBYTES) {
      return null;
    }
    return new SymmetricKey(b);
  }

  @:from static public inline function fromBase64(b64 : String) : SymmetricKey {
    return fromBytes(Base64.decode(b64));
  }

  public function toBase64() : String {
    return Base64.encode(this);
  }

  private function getData() : BytesData {
    return this.getData();
  }
}
