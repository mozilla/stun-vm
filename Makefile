# GNU makefile for Mozilla stun-server VMs

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# AWS region, etc.
REGION ?= sa-east-1
GROUP ?= stun
DESC ?= "Mozilla stun server"

sec-group:
	@echo "[${REGION}] creating security group ${GROUP}..."
	euca-create-group --region ${REGION} -d ${DESC} ${GROUP}
	euca-authorize --region ${REGION} -P tcp -p 3478 ${GROUP}
	euca-authorize --region ${REGION} -P udp -p 3478 ${GROUP}
	euca-authorize --region ${REGION} -P icmp ${GROUP}
	euca-describe-group --region ${REGION} ${GROUP}

sec-group-clean:
	@echo "[${REGION}] removing security group ${GROUP}..."
	euca-delete-group --region ${REGION} ${GROUP}

VM_LIST := sl6-stun

all: vm

vm: $(addsuffix .stamp, $(VM_LIST))

%.stamp: %.appl
	boxgrinder-build $<

# manual deps
sl6-stun.appl: sl6.appl
