package sodium;

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

  private function getData() : BytesData {
    return this.getData();
  }
}
