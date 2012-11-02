# GNU makefile for Mozilla stun-server VMs

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

VM_LIST := sl6-stun

all: vm

vm: $(addsuffix .stamp, $(VM_LIST))

%.stamp: %.appl
	boxgrinder-build $<

# manual deps
sl6-stun.appl: sl6.appl
