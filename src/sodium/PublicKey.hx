package sodium;

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

  @:from static private inline function fromBytes(b : Bytes) : PublicKey {
    if (b.length != SodiumWrapper.box_PUBLICKEYBYTES) {
      return null;
    }
    return new PublicKey(b);
  }

  private function getData() : BytesData {
    return this.getData();
  }
}