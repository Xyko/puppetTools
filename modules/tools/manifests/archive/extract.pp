define archive::extract (
  $target,
  $ensure=present,
  $src_target="puppet:///modules/tools/${name}",
  $root_dir='',
  $extension='tar.gz',
  $timeout=120) {

  if $root_dir != '' {
    $extract_dir = "${target}/${root_dir}"
  } else {
    $extract_dir = "${target}/${name}"
  }

  case $ensure {
    present: {

      $extract_zip = "unzip -o ${src_target}/${name}.${extension} -d ${target}"
      $extract_targz = "tar --no-same-owner --no-same-permissions -xzf ${src_target}/${name}.${extension} -C ${target}"
      $extract_tarbz2 = "tar --no-same-owner --no-same-permissions -xjf ${src_target}/${name}.${extension} -C ${target}"

      exec {"$name unpack":
        command => $extension ? {
          'zip' => "mkdir -p ${target} && ${extract_zip}",
          'tar.gz' => "mkdir -p ${target} && ${extract_targz}",
          'tgz' => "mkdir -p ${target} && ${extract_targz}",
          'tar.bz2' => "mkdir -p ${target} && ${extract_tarbz2}",
          'tgz2' => "mkdir -p ${target} && ${extract_tarbz2}",
          default => fail ( "Unknown extension value '${extension}'" ),
        },
        creates => $extract_dir,
        timeout => $timeout
      }
    }
    absent: {
      file {$extract_dir:
        ensure => absent,
        recurse => true,
        purge => true,
        force => true,
      }
    }
    default: { err ( "Unknown ensure value: '${ensure}'" ) }
  }
}

