#!/bin/bash

set -o errexit -o nounset

CT_NAMESPACE=http://release.niem.gov/niem/conformanceTargets/3.0/
RELEASE_DATE=2014-07-31
RELEASE_VERSION=3.0
# name and version
RELEASE_NV="NIEM-CTAS-$RELEASE_VERSION-$RELEASE_DATE"
CTU_XSL1_NAMESPACE=http://example.org/conformance-targets-utilities/xslt1/
CTU_XSL2_NAMESPACE=http://example.org/conformance-targets-utilities/xslt2/

