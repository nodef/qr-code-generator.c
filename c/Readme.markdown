QR Code generator library - C
=============================


Introduction
------------

This project aims to be the best, clearest QR Code generator library. The primary goals are flexible options and absolute correctness. Secondary goals are compact implementation size and good documentation comments.
By [Nayuki](https://github.com/nayuki).

Home page with live JavaScript demo, extensive descriptions, and competitor comparisons: https://www.nayuki.io/page/qr-code-generator-library


Installation
------------

Run:
```bash
$ npm i qr-code-generator.c
```

And then include `qrcodegen.h` as follows:
```c
#include "node_modules/qr-code-generator.c/c/qrcodegen.h"
```

You may also want to include `qrcodegen.c` as follows:
```c
#ifndef __QRCODEGEN_C__
#define __QRCODEGEN_C__
#include "node_modules/qr-code-generator.c/c/qrcodegen.c"
#endif
```

This will include both the function declaration and their definitions into a single file.


Features
--------

Core features:

* Significantly shorter code but more documentation comments compared to competing libraries
* Supports encoding all 40 versions (sizes) and all 4 error correction levels, as per the QR Code Model 2 standard
* Output format: Raw modules/pixels of the QR symbol
* Detects finder-like penalty patterns more accurately than other implementations
* Encodes numeric and special-alphanumeric text in less space than general text
* Completely avoids heap allocation (`malloc()`), instead relying on suitably sized buffers from the caller and fixed-size stack allocations
* Coded carefully to prevent memory corruption, integer overflow, platform-dependent inconsistencies, and undefined behavior; tested rigorously to confirm safety
* Open-source code under the permissive MIT License

Manual parameters:

* User can specify minimum and maximum version numbers allowed, then library will automatically choose smallest version in the range that fits the data
* User can specify mask pattern manually, otherwise library will automatically evaluate all 8 masks and select the optimal one
* User can specify absolute error correction level, or allow the library to boost it if it doesn't increase the version number
* User can create a list of data segments manually and add ECI segments

More information about QR Code technology and this library's design can be found on the project home page.


Examples
--------

```c
#include <stdbool.h>
#include <stdint.h>
#include "qrcodegen.h"

// Text data
uint8_t qr0[qrcodegen_BUFFER_LEN_MAX];
uint8_t tempBuffer[qrcodegen_BUFFER_LEN_MAX];
bool ok = qrcodegen_encodeText("Hello, world!",
    tempBuffer, qr0, qrcodegen_Ecc_MEDIUM,
    qrcodegen_VERSION_MIN, qrcodegen_VERSION_MAX,
    qrcodegen_Mask_AUTO, true);
if (!ok)
    return;

int size = qrcodegen_getSize(qr0);
for (int y = 0; y < size; y++) {
    for (int x = 0; x < size; x++) {
        (... paint qrcodegen_getModule(qr0, x, y) ...)
    }
}

// Binary data
uint8_t dataAndTemp[qrcodegen_BUFFER_LEN_FOR_VERSION(7)]
    = {0xE3, 0x81, 0x82};
uint8_t qr1[qrcodegen_BUFFER_LEN_FOR_VERSION(7)];
ok = qrcodegen_encodeBinary(dataAndTemp, 3, qr1,
    qrcodegen_Ecc_HIGH, 2, 7, qrcodegen_Mask_4, false);
```

More complete set of examples: https://github.com/nayuki/QR-Code-generator/blob/master/c/qrcodegen-demo.c .

<br>
<br>


[![ORG](https://img.shields.io/badge/org-nodef-green?logo=Org)](https://nodef.github.io)
![](https://ga-beacon.deno.dev/G-RC63DPBH3P:SH3Eq-NoQ9mwgYeHWxu7cw/github.com/nodef/qr-code-generator.c)
