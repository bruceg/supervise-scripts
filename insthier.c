#include "installer.h"
#include "conf_bin.c"
#include "conf_man.c"

void insthier(void) {
  int bin = opendir(conf_bin);
  int man = opendir(conf_man);
  int man1 = d(man, "man1", -1, -1, 0755);

  c(bin, "svc-add",               -1, -1, 0755);
  c(bin, "svc-build",             -1, -1, 0755);
  c(bin, "svc-isdown",            -1, -1, 0755);
  c(bin, "svc-isup",              -1, -1, 0755);
  c(bin, "svc-remove",            -1, -1, 0755);
  c(bin, "svc-restart",           -1, -1, 0755);
  c(bin, "svc-start",             -1, -1, 0755);
  c(bin, "svc-status",            -1, -1, 0755);
  c(bin, "svc-stop",              -1, -1, 0755);
  c(bin, "svc-waitdown",          -1, -1, 0755);
  c(bin, "svc-waitup",            -1, -1, 0755);
  c(bin, "svscan-add-to-inittab", -1, -1, 0755);
  c(bin, "svscan-start",          -1, -1, 0755);
  c(bin, "svscan-stopall",        -1, -1, 0755);

  c(man1, "svc-add.1",               -1, -1, 0644);
  c(man1, "svc-remove.1",            -1, -1, 0644);
  c(man1, "svc-start.1",             -1, -1, 0644);
  c(man1, "svc-stop.1",              -1, -1, 0644);
}
