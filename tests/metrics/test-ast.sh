#!/usr/bin/env bash
# The MIT License (MIT)
#
# Copyright (c) 2021-2023 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
set -e
set -o pipefail

temp=$1

java="${temp}/Foo long 'weird' name (--).java"
echo "class Foo extends Bar implements Boom, Hello {
    final File a;
    static String Z;
    void x() { }
    int y() { return 0; }
}" > "${java}"
"${LOCAL}/metrics/ast.py" "${java}" "${temp}/stdout"
grep "attrs 1" "${temp}/stdout" >/dev/null
grep "sattrs 1" "${temp}/stdout" >/dev/null
grep "mtds 2" "${temp}/stdout" >/dev/null
grep "impls 2" "${temp}/stdout" >/dev/null
grep "extnds 1" "${temp}/stdout" >/dev/null
echo "👍🏻 Correctly collected AST metrics"