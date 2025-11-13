
# This is compailed and costome made kernal module from kernal version 6.17.2 with linuwu-sense from github.

## the compiled module was worknig so we are taking its baackup only the liinuwu sense module we will save it on github and only copy its compiled code to the working nixStore

### this insure we have the code which works like kernal code which is improtant for EC values changing.

#### because its just a smll kernal module and secperat from orignal kernal we are free to upgrade kernal 🙌

##### thanks to GORK ai.


ORIGNAL PATHS:
$LINUWU_PATH  = /nix/store/rpnkj6q9kx754z2c241734v6gqpgh4ar-linuwu-sense-unstable-2025-09-06/lib/modules/6.17.2/extra/linuwu_sense.ko
$KERNEL_PATH = /nix/store/cg9wqx5qbsv0xn70cnc61br4jjih1v5l-linux-6.17.2-modules/lib/modules/6.17.2

WAY TO GET THE PATH:
  - Find the exact linuwu-sense module
        LINUWU_PATH=$(find /nix/store -name "linuwu_sense.ko" | head -1)
        echo $LINUWU_PATH

  - Find the kernel that matches
        KERNEL_PATH=$(find /nix/store -name "6.17.2" -type d | grep linux-6.17.2 | head -1)
        echo $KERNEL_PATH


