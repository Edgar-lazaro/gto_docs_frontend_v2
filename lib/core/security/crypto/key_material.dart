import 'package:pointycastle/export.dart';

class DevKeyMaterial {

  static final ECDomainParameters _domain =
      ECDomainParameters('secp256r1');

  /// Clave pública del desarrollador
  static final ECPublicKey publicKey = ECPublicKey(
    _domain.curve.createPoint(
      BigInt.parse(
        '11223344556677889900AABBCCDDEEFF11223344556677889900AABBCCDDEEFF',
        radix: 16,
      ),
      BigInt.parse(
        '99887766554433221100FFEEDDCCBBAA99887766554433221100FFEEDDCCBBAA',
        radix: 16,
      ),
    ),
    _domain,
  );
}