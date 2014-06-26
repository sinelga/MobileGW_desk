// Copyright (c) 2013-present, Iván Zaera Avellón - izaera@gmail.com

// This library is dually licensed under LGPL 3 and MPL 2.0. See file LICENSE for more information.

// This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of
// the MPL was not distributed with this file, you can obtain one at http://mozilla.org/MPL/2.0/.

library cipher.random.secure_random_base;

import "dart:typed_data";

import "package:bignum/bignum.dart";
import "package:cipher/api.dart";
import "package:cipher/src/ufixnum.dart";

/**
 * An utility base implementation of [SecureRandom] so that only [nextUint8] method needs to be
 * implemented.
 */
abstract class SecureRandomBase implements SecureRandom {

  int nextUint16() {
    var b0 = nextUint8();
    var b1 = nextUint8();
    return clip16((b1 << 8) | b0);
  }

  int nextUint32() {
    var b0 = nextUint8();
    var b1 = nextUint8();
    var b2 = nextUint8();
    var b3 = nextUint8();
    return clip32( (b3<<24) | (b2<<16) | (b1<<8) | b0 );
  }

  BigInteger nextBigInteger( int bitLength ) {
    return new BigInteger.fromBytes(1, _randomBits(bitLength));
  }

  Uint8List nextBytes( int count ) {
    var bytes = new Uint8List(count);
    for( var i=0 ; i<count ; i++ ) {
      bytes[i] = nextUint8();
    }
    return bytes;
  }

  List<int> _randomBits(int numBits) {
    if (numBits < 0) {
      throw new ArgumentError("numBits must be non-negative");
    }

    var numBytes = (numBits+7)~/8; // avoid overflow
    var randomBits = new Uint8List(numBytes);

    // Generate random bytes and mask out any excess bits
    if (numBytes > 0) {
      for( var i=0 ; i<numBytes ; i++ ){
        randomBits[i] = nextUint8();
      }
      int excessBits = 8*numBytes - numBits;
      randomBits[0] &= (1 << (8-excessBits)) - 1;
    }
    return randomBits;
  }

}
