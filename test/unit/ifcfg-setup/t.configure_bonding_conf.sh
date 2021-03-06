#!/bin/bash
#
# requires:
#   bash
#

## include files

. $(cd ${BASH_SOURCE[0]%/*} && pwd)/helper_shunit2.sh

## variables

declare device=bond0
IFCFG_BONDING_CONF_PATH=bonding.conf.$$

## functions

function setUp() {
  :
}

function tearDown() {
  rm  ${IFCFG_BONDING_CONF_PATH}
}

function test_configure_bonding_conf_no_opts() {
  configure_bonding_conf
  assertEquals 0 ${?}

  assertEquals "alias ${device} bonding" "$(cat ${IFCFG_BONDING_CONF_PATH})"
}

function test_configure_bonding_conf_opts() {
  configure_bonding_conf ${device}
  assertEquals 0 ${?}

  assertEquals "alias ${device} bonding" "$(cat ${IFCFG_BONDING_CONF_PATH})"
}

function test_configure_bonding_conf_opts_multi() {
  local bond2=bond2

  configure_bonding_conf ${device}
  configure_bonding_conf ${bond2}

  assertEquals "alias ${device} bonding
alias ${bond2} bonding" "$(cat ${IFCFG_BONDING_CONF_PATH})"
}

## shunit2

. ${shunit2_file}
