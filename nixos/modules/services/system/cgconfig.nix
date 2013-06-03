{pkgs, config, ...}:

let

  inherit (pkgs.lib) mkOption mkIf singleton;
  inherit (pkgs) libcgroup;

in

{

  ###### interface

  options = {

    services.cgconfig = {

      enable = mkOption {
        default = false;
        description = "Set up control groups.";
      };

      configuration = mkOption {
        default = "";
        example = ''
          group dsched {
              perm {
                  task {
                      uid = dsched;
                      gid = users;
                  }
                  admin {
                      uid = dsched;
                      gid = root;
                  }
              }
              blkio { }
              cpu { }
              cpuacct { }
              cpuset { # this requires some defaults
                  cpuset.cpus = 0-3; # use cores 0-3
                  cpuset.mems = 0;   # use socket (numa node) 0
              }
              devices { }
              freezer { }
              memory { }
              net_cls { }
              net_prio { }
              ns { }
          }
        '';
        description = "Configuration for initial cgconfig.";
      };
    };

  };


  ###### implementation

  config = mkIf config.services.cgconfig.enable {

    environment.systemPackages = [ libcgroup ];

    jobs.cgconfig =
      let conffile = pkgs.writeText "cgconfig.conf" config.services.cgconfig.configuration;
       in { description = "set up cgroup hierarchy";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${libcgroup}/sbin/cgconfigparser -l ${conffile} -s 1664";
          ExecStop = "${libcgroup}/sbin/cgclear -l ${conffile} -e";
          Type = "oneshot";
          RemainAfterExit = true;
        };
      };

  };

}
