#!/bin/sh

DESTDIR=/usr/share/nginx/html/puppetlabs/puppet7/el/9/x86_64

# FIXME: should test that this is in a volume, otherwise we'll be writing to the writeable layer
test -d "$DESTDIR" || mkdir -pv $DESTDIR

/usr/bin/reposync --repo puppet7 -p "$DESTDIR" --norepopath --newest-only --gpgcheck --quiet

cd "$DESTDIR"
/usr/bin/createrepo --update -q .
