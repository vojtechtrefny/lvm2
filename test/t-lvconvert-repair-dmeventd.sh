#!/bin/bash
# Copyright (C) 2008 Red Hat, Inc. All rights reserved.
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions
# of the GNU General Public License v.2.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

. ./test-utils.sh

prepare_vg 5
prepare_dmeventd

which mkfs.ext2 || exit 200

lvcreate -m 3 --ig -L 1 -n 4way $vg
lvchange --monitor y $vg/4way
disable_dev $dev2 $dev4
mkfs.ext2 $DM_DEV_DIR/$vg/4way
sleep 3 # FIXME : - (
enable_dev $dev2 $dev4
check mirror $vg 4way
check mirror_legs $vg 4way 2
