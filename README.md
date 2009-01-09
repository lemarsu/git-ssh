git-ssh
=======

<tt>git-ssh</tt> is a proxy to serve git repositories over ssh.

DESCRIPTION
===========

<tt>git-ssh</tt> can force your ssh server to handle only git requests. You can
allow your users to pull or push, but not to login or to do scf or sftp.

FEATURES
========

+ No other account creation to handle a new commiter.
+ Can chroot to a directory to limit access of the repository server.

Later :
+ Can allow read, write or none access to a repository on a user basis.

SYNOPSIS
========

Create a git user account

    # groupadd git
    # useradd -g git -h /var/git -m git
    # passwd

You need to put a strong password that you can immediately forget.

Prepare for ssh keys

    # mkdir ~git/.ssh
    # touch ~git/.ssh/authorized_keys
    # chown -R git:git ~git/.ssh
    # chmod 700 ~git/.ssh

When you have to add a key in the `~git/.ssh/authorized_keys`, simply add at the beginning of the line :

    command="/usr/bin/git-ssh -r /var/git lemarsu"

For example:

    command="/usr/bin/git-ssh -r /var/git lemarsu" ssh-dss [...] lemarsu@zorglub

The `-r` option ask `git-ssh` to chroot the folder `/var/git`. This way, the
users cannot get away from the directory of repositories.

CREDITS
=======

LeMarsu `<ch dot ruelle at lemarsu dot com>`

LICENSE
=======

See file COPYING.
