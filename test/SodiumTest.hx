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

    public function __init__() {
      haxe.macro.Compiler.includeFile('../sodium.min.js');
    }

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
	}
	
	@After
	public function tearDown():Void
	{
	}
	
	
	@Test
	public function testPwhash():Void
	{
      var pw1 = "Hello";
      var pw2 = "Bye";
      var resultLength = 128;
      var hash1 = SodiumWrapper.crypto_pwhash_zero_salt(pw1, resultLength);
      var hash2 = SodiumWrapper.crypto_pwhash_zero_salt(pw2, resultLength);
      var hash3 = SodiumWrapper.crypto_pwhash_zero_salt(pw1, resultLength);
      Assert.isTrue(hash1.compare(hash3) == 0);
      Assert.isFalse(hash1.compare(hash2) == 0);
	}

    @Test
    public function testCryptoBox():Void {
      var keys = SodiumWrapper.crypto_box_keypair();
      var publicKey = keys.publicKey;
      var privateKey = keys.privateKey;
      var message = "Hello, World";
      var encrypted = SodiumWrapper.crypto_box_seal(Bytes.ofString(message), publicKey);
      var decrypted = SodiumWrapper.crypto_box_seal_open(encrypted, publicKey, privateKey);
      Assert.areEqual(decrypted.toString(),message);
    }

	
	
	
	/**
	* test that only runs when compiled with the -D testDebug flag
	*/
	@TestDebug
	public function testExampleThatOnlyRunsWithDebugFlag():Void
	{
		Assert.isTrue(true);
	}

}
