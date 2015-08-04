package sodium;

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

  private function getData() : BytesData {
    return this.getData();
  }
}
