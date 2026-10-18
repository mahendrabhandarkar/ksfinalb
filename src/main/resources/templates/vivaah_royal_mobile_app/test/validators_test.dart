import 'package:flutter_test/flutter_test.dart';
import 'package:vivaah_royal/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('accepts well-formed addresses', () {
      expect(Validators.email('aisha.khan@example.com'), isNull);
      expect(Validators.email('arjun+royal@vivaah.co.in'), isNull);
    });

    test('rejects malformed addresses', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('not-an-email'), isNotNull);
      expect(Validators.email('missing@tld'), isNotNull);
      expect(Validators.email(null), isNotNull);
    });
  });

  group('Validators.phone', () {
    test('accepts 10-digit Indian numbers starting 6-9', () {
      expect(Validators.phone('9876543210'), isNull);
      expect(Validators.phone('+91 98765 43210'), isNull);
    });

    test('rejects invalid numbers', () {
      expect(Validators.phone('12345'), isNotNull);
      expect(Validators.phone('1234567890'), isNotNull);
      expect(Validators.phone(''), isNotNull);
    });
  });

  group('Validators.password', () {
    test('requires length plus letter and digit', () {
      expect(Validators.password('royal12'), isNull);
      expect(Validators.password('abc123'), isNull);
    });

    test('rejects weak passwords', () {
      expect(Validators.password('123456'), isNotNull);
      expect(Validators.password('abcdef'), isNotNull);
      expect(Validators.password('ab1'), isNotNull);
      expect(Validators.password(''), isNotNull);
    });
  });

  group('Validators.name and otp', () {
    test('name requires letters and length >= 2', () {
      expect(Validators.name('Ananya Deshmukh'), isNull);
      expect(Validators.name('A'), isNotNull);
      expect(Validators.name('12345'), isNotNull);
    });

    test('otp requires exactly six digits', () {
      expect(Validators.otp('123456'), isNull);
      expect(Validators.otp('12345'), isNotNull);
      expect(Validators.otp('abcdef'), isNotNull);
    });
  });
}
