define xyko::extract (
  $target,
  $ensure=present,
  $extension='tar.gz',
  $timeout=120,
  $execute='') {


      file { "/tmp/${name}.${extension}":
        ensure => file,
        source => "puppet:///modules/xyko/${name}/${name}.${extension}",
      }

      $extract_dir  = "${target}/${name}"
      $src_target   = "/tmp/${name}.${extension}"

      case $ensure {
        present: {

          $extract_zip    = "unzip -o ${src_target} -d ${target}"
          $extract_targz  = "tar --no-same-owner --no-same-permissions -xzf ${src_target} -C ${target}"
          $extract_tarbz2 = "tar --no-same-owner --no-same-permissions -xjf ${src_target} -C ${target}"

          exec {"$name unpack":
            path    => "/bin:/sbin:/usr/bin:/usr/sbin",
            command => $extension ? {
              'zip'     => "mkdir -p ${target} && ${extract_zip}",
              'tar.gz'  => "mkdir -p ${target} && ${extract_targz}",
              'tgz'     => "mkdir -p ${target} && ${extract_targz}",
              'tar.bz2' => "mkdir -p ${target} && ${extract_tarbz2}",
              'tgz2'    => "mkdir -p ${target} && ${extract_tarbz2}",
              default   => fail ( "Unknown extension value '${extension}'" ),
            },
            creates => $extract_dir,
            timeout => $timeout,
          }

          notice $extract_dir
          exec {"$name execute":
            path    => "/bin:/sbin:/usr/bin:/usr/sbin",
            #command => "sudo bash -c 'cd  ${extract_dir} && ./configure --prefix=/opt/${projeto}/nginx && make && make install'",
            command => $execute,
            timeout => $timeout,
          }

        }
        absent: {
          file {$extract_dir:
            ensure  => absent,
            recurse => true,
            purge   => true,
            force   => true,
          }
        }
        default: { err ( "Unknown ensure value: '${ensure}'" ) }
      }

}

