LA
==

Register Listing for LA
-----------------------

+--------------------------+-----------------------------+
| Register                 | Address                     |
+==========================+=============================+
| :ref:`LA_IEN3 <LA_IEN3>` | :ref:`0xc8003000 <LA_IEN3>` |
+--------------------------+-----------------------------+
| :ref:`LA_IEN2 <LA_IEN2>` | :ref:`0xc8003004 <LA_IEN2>` |
+--------------------------+-----------------------------+
| :ref:`LA_IEN1 <LA_IEN1>` | :ref:`0xc8003008 <LA_IEN1>` |
+--------------------------+-----------------------------+
| :ref:`LA_IEN0 <LA_IEN0>` | :ref:`0xc800300c <LA_IEN0>` |
+--------------------------+-----------------------------+
| :ref:`LA_OE3 <LA_OE3>`   | :ref:`0xc8003010 <LA_OE3>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OE2 <LA_OE2>`   | :ref:`0xc8003014 <LA_OE2>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OE1 <LA_OE1>`   | :ref:`0xc8003018 <LA_OE1>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OE0 <LA_OE0>`   | :ref:`0xc800301c <LA_OE0>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN3 <LA_IN3>`   | :ref:`0xc8003020 <LA_IN3>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN2 <LA_IN2>`   | :ref:`0xc8003024 <LA_IN2>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN1 <LA_IN1>`   | :ref:`0xc8003028 <LA_IN1>`  |
+--------------------------+-----------------------------+
| :ref:`LA_IN0 <LA_IN0>`   | :ref:`0xc800302c <LA_IN0>`  |
+--------------------------+-----------------------------+
| :ref:`LA_OUT3 <LA_OUT3>` | :ref:`0xc8003030 <LA_OUT3>` |
+--------------------------+-----------------------------+
| :ref:`LA_OUT2 <LA_OUT2>` | :ref:`0xc8003034 <LA_OUT2>` |
+--------------------------+-----------------------------+
| :ref:`LA_OUT1 <LA_OUT1>` | :ref:`0xc8003038 <LA_OUT1>` |
+--------------------------+-----------------------------+
| :ref:`LA_OUT0 <LA_OUT0>` | :ref:`0xc800303c <LA_OUT0>` |
+--------------------------+-----------------------------+

LA_IEN3
^^^^^^^

`Address: 0xc8003000 + 0x0 = 0xc8003000`

    Bits 96-127 of `LA_IEN`. LA Input Enable

    .. wavedrom::
        :caption: LA_IEN3

        {
            "reg": [
                {"name": "ien[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IEN2
^^^^^^^

`Address: 0xc8003000 + 0x4 = 0xc8003004`

    Bits 64-95 of `LA_IEN`.

    .. wavedrom::
        :caption: LA_IEN2

        {
            "reg": [
                {"name": "ien[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IEN1
^^^^^^^

`Address: 0xc8003000 + 0x8 = 0xc8003008`

    Bits 32-63 of `LA_IEN`.

    .. wavedrom::
        :caption: LA_IEN1

        {
            "reg": [
                {"name": "ien[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IEN0
^^^^^^^

`Address: 0xc8003000 + 0xc = 0xc800300c`

    Bits 0-31 of `LA_IEN`.

    .. wavedrom::
        :caption: LA_IEN0

        {
            "reg": [
                {"name": "ien[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE3
^^^^^^

`Address: 0xc8003000 + 0x10 = 0xc8003010`

    Bits 96-127 of `LA_OE`. LA Output Enable

    .. wavedrom::
        :caption: LA_OE3

        {
            "reg": [
                {"name": "oe[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE2
^^^^^^

`Address: 0xc8003000 + 0x14 = 0xc8003014`

    Bits 64-95 of `LA_OE`.

    .. wavedrom::
        :caption: LA_OE2

        {
            "reg": [
                {"name": "oe[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE1
^^^^^^

`Address: 0xc8003000 + 0x18 = 0xc8003018`

    Bits 32-63 of `LA_OE`.

    .. wavedrom::
        :caption: LA_OE1

        {
            "reg": [
                {"name": "oe[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OE0
^^^^^^

`Address: 0xc8003000 + 0x1c = 0xc800301c`

    Bits 0-31 of `LA_OE`.

    .. wavedrom::
        :caption: LA_OE0

        {
            "reg": [
                {"name": "oe[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN3
^^^^^^

`Address: 0xc8003000 + 0x20 = 0xc8003020`

    Bits 96-127 of `LA_IN`. LA Input(s) Status.

    .. wavedrom::
        :caption: LA_IN3

        {
            "reg": [
                {"name": "in[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN2
^^^^^^

`Address: 0xc8003000 + 0x24 = 0xc8003024`

    Bits 64-95 of `LA_IN`.

    .. wavedrom::
        :caption: LA_IN2

        {
            "reg": [
                {"name": "in[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN1
^^^^^^

`Address: 0xc8003000 + 0x28 = 0xc8003028`

    Bits 32-63 of `LA_IN`.

    .. wavedrom::
        :caption: LA_IN1

        {
            "reg": [
                {"name": "in[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_IN0
^^^^^^

`Address: 0xc8003000 + 0x2c = 0xc800302c`

    Bits 0-31 of `LA_IN`.

    .. wavedrom::
        :caption: LA_IN0

        {
            "reg": [
                {"name": "in[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT3
^^^^^^^

`Address: 0xc8003000 + 0x30 = 0xc8003030`

    Bits 96-127 of `LA_OUT`. LA Ouptut(s) Control.

    .. wavedrom::
        :caption: LA_OUT3

        {
            "reg": [
                {"name": "out[127:96]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT2
^^^^^^^

`Address: 0xc8003000 + 0x34 = 0xc8003034`

    Bits 64-95 of `LA_OUT`.

    .. wavedrom::
        :caption: LA_OUT2

        {
            "reg": [
                {"name": "out[95:64]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT1
^^^^^^^

`Address: 0xc8003000 + 0x38 = 0xc8003038`

    Bits 32-63 of `LA_OUT`.

    .. wavedrom::
        :caption: LA_OUT1

        {
            "reg": [
                {"name": "out[63:32]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


LA_OUT0
^^^^^^^

`Address: 0xc8003000 + 0x3c = 0xc800303c`

    Bits 0-31 of `LA_OUT`.

    .. wavedrom::
        :caption: LA_OUT0

        {
            "reg": [
                {"name": "out[31:0]", "bits": 32}
            ], "config": {"hspace": 400, "bits": 32, "lanes": 1 }, "options": {"hspace": 400, "bits": 32, "lanes": 1}
        }


