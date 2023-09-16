# GPG

## GitHub's GPG Key

Without having GitHub's GPG key in the keychain, signatures for merge commits made by GitHub will show up as follows (`git log --show-signature`):

```text
commit 478f512d2c4c379b29893b012ca717dbb85b5869 (upstream/master, origin/master, origin/HEAD, master)
gpg: Signature made Do 17 Aug 13:29:15 2023 CEST
gpg:                using RSA key 4AEE18F83AFDEB23
gpg: Can't check signature: No public key
Author: Gregor Zurowski <gregor@zurowski.org>
Date:   Thu Aug 17 13:29:15 2023 +0200
```

This can be addressed by importing GitHub's GPG key into the keychain:

```bash
curl https://github.com/web-flow.gpg | gpg --import
```

Verify the imported key:

```bash
gpg --fingerprint 4AEE18F83AFDEB23
```

This will change the message displayed by `git log --show-signature` as follows:

```text
commit 478f512d2c4c379b29893b012ca717dbb85b5869 (upstream/master, origin/master, origin/HEAD, master)
gpg: Signature made Do 17 Aug 13:29:15 2023 CEST
gpg:                using RSA key 4AEE18F83AFDEB23
gpg: Good signature from "GitHub (web-flow commit signing) <noreply@github.com>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 5DE3 E050 9C47 EA3C F04A  42D3 4AEE 18F8 3AFD EB23
Author: Gregor Zurowski <gregor@zurowski.org>
Date:   Thu Aug 17 13:29:15 2023 +0200
```
