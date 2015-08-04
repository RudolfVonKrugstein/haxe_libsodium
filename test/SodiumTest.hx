package;

import massive.munit.Assert;
import sodium.SodiumWrapper;
import haxe.io.Bytes;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class SodiumTest
{
	public function new()
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void
	{
	}
	
	@AfterClass
	public function afterClass():Void
	{
	}
	
	@Before
	public function setup():Void
	{
      SodiumWrapper.init();
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	
	@TestDebug
	@Test
	public function testPwhash():Void
	{
      var pw1 = "Hello";
      var pw2 = "Bye";
      var resultLength = 128;
      var hash1 = SodiumWrapper.pwhash_zero_salt(pw1, resultLength);
      var hash2 = SodiumWrapper.pwhash_zero_salt(pw2, resultLength);
      var hash3 = SodiumWrapper.pwhash_zero_salt(pw1, resultLength);
      Assert.areEqual(hash1.length,resultLength);
      Assert.areEqual(hash2.length,resultLength);
      Assert.areEqual(hash3.length,resultLength);
      Assert.isTrue(hash1.compare(hash3) == 0);
      Assert.isFalse(hash1.compare(hash2) == 0);
	}

	@TestDebug
    @Test
    public function testCryptoBox():Void {
      var keys = SodiumWrapper.box_keypair();
      var publicKey = keys.publicKey;
      var privateKey = keys.secretKey;
      var message = "Hello, World";
      var encrypted = SodiumWrapper.box_seal(Bytes.ofString(message), publicKey);
      if (encrypted == null) {
        Assert.isTrue(false);
      } else {
        var decrypted = SodiumWrapper.box_seal_open(encrypted, publicKey, privateKey);
        if (decrypted == null) {
          Assert.isTrue(false);
        } else {
          Assert.areEqual(decrypted.toString(),message);
        }
      }
    }

	@TestDebug
    @Test
    public function testSecretBox():Void {
      var key = SodiumWrapper.randombytes(SodiumWrapper.secretbox_KEYBYTES);
      var message = "Hello, Secret World";
      var encrypted = SodiumWrapper.secretbox_easy_no_nonce(Bytes.ofString(message), key);
      if (encrypted == null) {
        Assert.isTrue(false);
      } else {
        var decrypted = SodiumWrapper.secretbox_open_easy_no_nonce(encrypted, key);
        if (decrypted == null) {
          Assert.isTrue(false);
        } else {
          Assert.areEqual(decrypted.toString(),message);
        }
      }

    }
	
	

}
