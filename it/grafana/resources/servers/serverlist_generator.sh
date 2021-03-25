#!/usr/bin/env bash
USER='hreinking_b'

ssh -l $USER foreman.ls.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' > server_list.txt
ssh -l $USER foreman.cp.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' >> server_list.txt
ssh -l $USER foreman.dev.lsst.org 'sudo /usr/bin/hammer host list --fields Name | grep lsst.org' >> server_list.txt