#!/bin/sh

EL_VERSION=${EL_VERSION:-8}

DESTDIR=/usr/share/nginx/html/puppetlabs/puppet7/el/${EL_VERSION}/x86_64

# FIXME: should test that this is in a volume, otherwise we'll be writing to the writeable layer
test -d "$DESTDIR" || mkdir -pv $DESTDIR

# ugh. This is awful.
cat > /etc/yum.repos.d/puppet7.repo << EOF
[puppet7]
name=Puppet 7 Repository - \$basearch
baseurl=http://yum.puppetlabs.com/puppet7/el/${EL_VERSION}/\$basearch
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet-20250406
       file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppet
enabled=1
gpgcheck=1
EOF

/usr/bin/reposync --repo puppet7 -p "$DESTDIR" --norepopath --newest-only --gpgcheck --quiet

cd "$DESTDIR"
/usr/bin/createrepo --update -q .
