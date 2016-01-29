basename $1 | tr '\n' ' '; echo -n "SHA1 "; shasum $1 | cut -d " " -f 1;
basename $1 | tr '\n' ' '; echo -n "SHA256 "; sha256sum $1 | cut -d " " -f 1;
basename $1 | tr '\n' ' '; echo -n "MD5 "; md5sum $1 | cut -d " " -f 1;


