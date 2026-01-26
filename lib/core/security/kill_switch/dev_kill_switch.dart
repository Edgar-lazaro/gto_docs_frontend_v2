import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/asn1.dart';

import '../crypto/key_material.dart';

class DevKillSwitch {
  static const _requiredFields = ['action', 'timestamp'];

  static bool verify({
    required Map<String, dynamic> payload,
    required String signatureBase64,
  }) {
    try {
      // Validación semántica
      if (!_isValidPayload(payload)) return false;

      // Anti-replay (5 minutos)
      if (!_isFresh(payload['timestamp'])) return false;


      final sigBytes = base64Decode(signatureBase64);
      final ecSignature = _decodeDERSignature(sigBytes);
      if (sigBytes.length < 8) return false;

      // Preparar verificador
      final signer = Signer('SHA-256/ECDSA');


      signer.init(
        false,
        PublicKeyParameter<ECPublicKey>(DevKeyMaterial.publicKey),
      );

      final data = utf8.encode(jsonEncode(payload));

      return signer.verifySignature(data, ecSignature);
    } catch (_) {
      return false;
    }
  }

  static bool _isValidPayload(Map<String, dynamic> payload) {
    for (final k in _requiredFields) {
      if (!payload.containsKey(k)) return false;
    }
    return payload['action'] == 'BLOCK_APP';
  }

  static bool _isFresh(dynamic timestamp) {
  if (timestamp is! int) return false;

  final now = DateTime.now().millisecondsSinceEpoch;
  const maxSkew = 5 * 60 * 1000;
  return (now - timestamp).abs() <= maxSkew;
}

static ECSignature _decodeDERSignature(Uint8List bytes) {
  final parser = ASN1Parser(bytes);
  final seq = parser.nextObject() as ASN1Sequence;

  final rBytes =
      (seq.elements![0] as ASN1Integer).valueBytes!;
  final sBytes =
      (seq.elements![1] as ASN1Integer).valueBytes!;

  final r = _bytesToBigInt(rBytes);
  final s = _bytesToBigInt(sBytes);

  return ECSignature(r, s);
}

static BigInt _bytesToBigInt(Uint8List bytes) {
  BigInt result = BigInt.zero;
  for (final b in bytes) {
    result = (result << 8) | BigInt.from(b);
  }
  return result;
}

}