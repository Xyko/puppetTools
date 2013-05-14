#
# Class: tools::users::params
#
# Definições de usuários e grupos para todos os projetos.
#
# Dados que podem ser definidos para cada usuário, identificado pelo username:
#
# - uid:        uid para este usuário (obrigatório)
#
# - group:      nome de grupo para este usuário, por default é igual ao username
#
# - gid:        gid para este usuário, se não definido fica igual ao uid
#
# - shell:      login shell, se não definido será /bin/bash onde o usuário puder logar,
#               se chamado com false usa /sbin/nologin
#
# - home:       home dir, se não definido será /home/${username}, use 'false' (string)
#               para não criar, graças a um bug do Puppet 2.7.x
#
# - pass_dev:   senha criptografada para os ambientes vagrant, dev, qa1 e qa2, se não for
#               especificada, usa o próprio username; use 'false' (string) para manter bloqueado
#
# - pass_prod:  senha criptografada para os ambientes staging e prod, se não for especificada
#               não altera a senha existente, o que significa uma senha desabilitada para
#               usuários novos criados pelo puppet-setup; use 'false' (string) para manter bloqueado
#
# - groups:     lista de grupos adicionais para o usuário (opcional)
#
# - allowdupe:  permite a criação de usuários e grupos com uids e/ou gids duplicados; use apenas
#               para manter a compatibilidade com o legado
#
# - system:     indica que é um usuário de sistema, ou seja, não está associado a
#               nenhuma aplicação do portal, sendo false por defaut; usado para evitar
#               a criação deste usuário em máquinas compartilhadas, como estáticos e filer,
#               além de não instalar as chaves padrão de acesso para estes usuários
# - usepma:     indica que é um usuário de alguma aplicação que ainda usa o sistema de PMA
#               para deploy, por isso precisa das chaves públicas desse sistema
#
# - userundeck: indica que é um usuário uma aplicação que ainda usa o sistema de PMA
#               para deploy, por isso precisa das chaves públicas desse sistema
#
# Obs: Para gerar o hash da senha em MD5, uma forma rápida em comando de linha:
#    echo "senha" | openssl passwd -1 -stdin
#

class tools::users::params {

  # Mapeamento de usuários dos projetos da Globo.com
  $map = {
    #
    # IDs de sistema, apenas para garantir sua existencia e formato - Não use!
    #
    #'nobody'    => {
    #  uid       => '99',
    #  home      => 'false',
    #  shell     => 'false',
    #  pass_dev  => 'false',
    #  pass_prod => 'false',
    #  system    => true,    # não pertence a nenhuma aplicação do portal
    #},
    #
    # Estes IDs devem ser modificados: todos devem estar entre 10000 e 20000
    #
    'puppet'    => {
      uid       => '52',
      pass_prod => '$1$3SnhJVdY$Euu5Cco4R7U8Mai3iSRww/',
      home      => '/opt/puppet',
      #system    => true,    # XXX deixa como app por enquanto -- não pertence a nenhuma aplicação do portal
    },
    # Usado no CVS, PMA e One Click Deploy, dá conflito com um grupo padrão do CentOS
    'cvs' => {
      uid       => '103',   # fora do padrão
      gid       => '103',
      allowdupe => true,
      home      => 'false',
      shell     => 'false',
      pass_dev  => 'false',
      pass_prod => 'false',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    # Usado no CVS, PMA e One Click Deploy
    'globocom' => {
      uid       => '104',   # fora do padrão
      gid       => '104',
      home      => 'false',
      shell     => 'false',
      pass_dev  => 'false',
      pass_prod => 'false',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'votacao' => {
      uid       => '500',   # fora do padrão
      gid       => '12351',
      allowdupe => true,
      pass_prod => '$1$RWQIe2TG$7n/JbWvWPqeeKumfvqFx/.',
    },
    'git' => {              # Git usado antigamente, ninguém mais deveria usar
      uid       => '500',   # fora do padrão
      gid       => '501',
      allowdupe => true,
      home      => 'false',
      shell     => 'false',
      pass_dev  => 'false',
      pass_prod => 'false',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    # Só existe nas máquinas da Fast, mas gid = 501 é duplicado com 'pma'
    'fastuser' => {
      uid       => '501',   # fora do padrão
      allowdupe => true,
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'wp' => {
      uid       => '3300',  # fora do padrão
    },
    'suporte' => {
      uid       => '3301',  # fora do padrão
      pass_prod => '$1$TxTlrrfk$xMDNlYTOqxQVhtEZ5CMti0',
    },
    #
    # Estes IDs estão acima de 10000, mas fora do padrão dos demais
    #
    'db_arq' => {
      uid         => '10000', # fora do padrão
      system      => true,    # não pertence a nenhuma aplicação do portal
      pass_dev    => '$1$AR9xCDBJ$Y2EdkmGuAfJmZA3SEBYJ20',
      pass_prod   => '$1$AR9xCDBJ$Y2EdkmGuAfJmZA3SEBYJ20',
      # Em muitos lugares o gid está como 13101, mas pelo menos mudar o gid não dá tanto problema
      use_rundeck => true,
    },
    'redmine' => {
      uid       => '10061',  # fora do padrão
    },
    'centos' => {
      uid       => '10240',  # fora do padrão
      pass_prod => '$1$3QdwqEF.$Pc7FM3olMQ6dGAvaBiMvs.',
      groups    => ['mirror'],
    },
    'ubuntu' => {
      uid       => '10241',  # fora do padrão
      pass_prod => '$1$1R/p7mxY$sfChkYVZHAVpv95zCgv0z1',
      groups    => ['mirror'],
    },
    'futpedia' => {
      uid       => '10700',  # fora do padrão
    },
    'reuters' => {
      uid       => '10903',  # fora do padrão
    },
    'ispapp' => {
      uid       => '11000',  # fora do padrão
      gid       => '10000',
      pass_prod => '$1$u0MLna7Y$dAsvDJZeZeag1cSVpilpU1',
      groups    => ['thumborclient'],
      usepma    => true,
    },
    'sde' => {
      uid       => '11003',  # fora do padrão
    },
    #
    # Aqui começa o bloco padrão atual, a partir de 12000
    #
    'cadun' => {
      uid       => '12000',
      pass_prod => '$1$8yKSMW6Z$d6Cpo6mXEuIj/U036i5J41',
    },
    'portal' => {
      uid       => '12206',
      pass_prod => '$1$j72ABgvf$PMQDD.MoDXm2WY9/yn6Js1',
      groups    => ['thumborclient'],
    },
    'watcher' => {
      uid       => '12207',
      pass_dev  => '$1$mV2JdIPU$dOMLZEaoRJEB0NIqW/xaZ/',
      pass_prod => '$1$mV2JdIPU$dOMLZEaoRJEB0NIqW/xaZ/',
    },
    'dynamo' => {
      uid       => '12208',
      groups    => ['thumborclient'],
    },
    'mfm' => {
      uid       => '12209',
    },
    'virt' => {
      uid       => '12212',
    },
    'static' => {
      uid       => '12213',
      pass_prod => '$1$5jng0Uah$X9LEs9quSaebhbHYIsyRK.',
    },
    'deploy' => {
      uid       => '12214',
      system    => true,        # não pertence a nenhuma aplicação do portal
      # groups    => [ 'pma' ],
    },
    'networkapi' => {
      uid       => '12215',
    },
    'mcached' => {
      uid       => '12216',
      pass_prod => '$1$1wii51Fj$Jr9Clb8FCTboLOHR6rcn5.',
    },
    'mediawiki' => {
      uid       => '12217',
    },
    'sce' => {
      uid       => '12218',
    },
#    'fvideo' => {          # Está duplicado! Raios!
#      uid       => '12219',
#    },
    'ads2' => {
      uid       => '12220',
    },
    'vodubbb' => {
      uid       => '12222',
    },
    'anuncie' => {
      uid       => '12223',
    },
    'cartola' => {
      uid       => '12224',
      pass_prod => '$1$5D79fRQS$Gb3k8fx0szbIQeCmwHCAk0',
    },
    'social' => {
      uid       => '12225',
    },
    'ds' => {
      uid       => '12228',
    },
    'intranet' => {
      uid       => '12229',
    },
    'deploy_prod' => {
      uid       => '12230', # muito mais complicado do que isso
      pass_dev  => 'false', # string por causa de um bug sinistro
      # sem pass_prod porque será definida manualmente nas máquinas
      system    => true,    # não pertence a nenhuma aplicação do portal
      groups    => [ 'deploy' ],
    },
#    'deploy_qa2' => {
#      uid       => '12231',  # Não deve mais ser necessário
#    },
    'pypi' => {
      uid       => '12232',
      pass_prod => '$1$ZfNbzdPV$OsO9v9B3VrDZ8z.lRxgJv0',
    },
    'sede' => {
      uid       => '12330',
    },
    'activemq' => {
      uid       => '12331',
    },
    'participe' => {
      uid       => '12332',
    },
    'nginx' => {
      uid       => '12333',
      home      => 'false',
      shell     => 'false',
      pass_dev  => 'false',
      pass_prod => 'false',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'tr' => {
      uid       => '12334',
      pass_prod => '$1$Bq8pQNZV$uAa6GNknAwiB8ES66vKNI.',
    },
    'admcartola' => {
      uid       => '12335',
    },
    'wroom' => {
      uid       => '12336',
    },
    'receitas' => {
      uid       => '12337',
      groups    => ['thumborclient'],
    },
    'bbbnp' => {
      uid       => '12338',
    },
    'nagios' => {
      uid       => '12339',
    },
    'efv3' => {
      uid       => '12340',
    },
    'realtime' => {
      uid       => '12341',
      pass_prod => '$1$2ypSbk/T$BEqQcg7vExtwKWzvQFCYc0',
      pass_dev => '$1$Lf35S2KJ$L/WGyhLGXywCyREmMaKxZ/',
    },
    'realtime_' => {
      uid       => '12342',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_prod => '$1$2ypSbk/T$BEqQcg7vExtwKWzvQFCYc0',
      pass_dev  => '$1$Lf35S2KJ$L/WGyhLGXywCyREmMaKxZ/',
    },
#    'fvideo' => {          # Está duplicado! Raios!
#      uid       => '12342',
#    },
    'newsfeed' => {
      uid       => '12343',
    },
    'edglobo' => {
      uid       => '12345',
    },
    'webmediaadmin' => {
      uid       => '12346',
    },
    'monitor' => {
      uid       => '12347',
    },
    'fms' => {
      uid       => '12348',
    },
    'geoip' => {
      uid       => '12349',
    },
    'g1api' => {
      uid       => '12350',
      pass_prod => '$1$2ypSbk/T$BEqQcg7vExtwKWzvQFCYc0',
      pass_dev  => '$1$ifC3fF28$M7Ly0MqEFBUbLZ./FJRpX/',
    },
    # Falta o 12351 que é o gid do votacao
    'videothumbs' => {
      uid       => '12352',
    },
    'pushmgr' => {
      uid       => '12353',
    },
    'catalogo' => {
      uid       => '12354',
    },
#    'xswm' => {    # mais complicado do que isso, provavelmente nunca funcionará aqui
#      uid       => '12355',
#      pass_dev  => '$1$2b5/LL29$.NzPlqnIS6HUmYTykRR7U1',
#      pass_prod => '$1$2b5/LL29$.NzPlqnIS6HUmYTykRR7U1',
#    },
    'reporting' => {
      uid       => '12355',
    },
    'agente' => {
      uid       => '12356',
      pass_dev  => '$1$uTcWXPoS$uT/gnIv7aOgvWn/en6TYc0',
      pass_prod => '$1$uTcWXPoS$uT/gnIv7aOgvWn/en6TYc0',
    },
    'salveaweb' => {
      uid       => '12357',
    },
    'sawpf' => {
      uid       => '12358',
      pass_prod => '$1$RJFRRyoM$ECum1fTyY5b7JUNR5iJlT/',
    },
    'thumbor' => {
      uid       => '12359',
      pass_prod => '$1$Y3chVsRU$LzhtqT8yVwYl/6WJ8rMp.0',
    },
    'sftponly' => {
      uid       => '12360',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
    },
    #'rubygems' => { # Antigo, não use!
      #uid       => '12361',
      #pass_prod => '$1$akuu7wNy$OXu.Gen.s4A2zUNCGG7KA/',
    #},
    'glog' => {
      uid       => '12362',
    },
    'globoapi' => {
      uid       => '12363',
    },
    'pfc' => {
      uid       => '12364',
      pass_prod => '$1$KsADJ3ff$z1TdJdAVFmV4ibQ5EUdHt/',
    },
#    'musica' => {
#      uid       => '12365',  # muito mais complicado
#    },
    'cobertura' => {
      uid       => '12366',
      pass_prod => '$1$ZGA82S5o$pMTB7O9BXOrwQLskPYFjA.',
    },
    'ejabberd' => {
      uid       => '12367',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      pass_prod => 'false', # string por causa de um bug sinistro
    },
    'portal_' => {
      uid       => '12368',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_prod => '$1$j72ABgvf$PMQDD.MoDXm2WY9/yn6Js1',
      groups    => ['thumborclient'],
    },
    'efcommon' => {
      uid       => '12369',
      shell     => false,
    },
    'fastercts' => {
      uid       => '12370',
      pass_prod => '$1$sdskdoJW$jPiCavHZ2fjZEWYws.qzI/',
    },
    'memcached' => {
      uid       => '12371',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      pass_prod => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'globovideo' => {
      uid       => '12372',
    },
    'webfonts' => {
      uid       => '12373',
    },
    'eugenia' => {
      uid       => '12374',
    },
    'lognit' => {
      uid       => '12375',
    },
    'vmine' => {
      uid       => '12376',
    },
    'thumborclient' => {
      uid       => '12377',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      pass_prod => 'false', # string por causa de um bug sinistro
    },
    'redis' => {
      uid       => '12378',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_prod => '$1$jhcvoieh$Fh2C14uuOJ37o35lEEDez/',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'portal_home' => {
      uid       => '12379',
      pass_prod => '$1$S/WlMa5y$vqoExzCgVN5K9j2FUHKj.0',
      groups    => ['thumborclient'],
    },
    'thumbs' => {
      uid       => '12380',
      pass_prod => '$1$QAwd/U47$Aq5prt7esCAtkc4PCBIU8/',
    },
    'busca' => {
      uid       => '12381',
      pass_prod => '$1$sZEtlbAJ$F4jygQlwgLXsVKriSyKS31',
      groups    => ['portal', 'thumborclient'],
      usepma    => true,
    },
    'nightcap' => {
      uid       => '12382',
    },
    'hydra' => {
      uid       => '12383',
    },
    'puppet_homolog' => {       # Usuario para fazer deploy dos ambientes homolog no puppet-master
      uid       => '12384',
      home      => '/opt/puppet_homolog',
      pass_prod => '$1$L/mBtp04$o4oLGXimutGk6qkDNwx.y0',
      pass_dev  => '$1$L/mBtp04$o4oLGXimutGk6qkDNwx.y0',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'cubo' => {
      uid       => '12385',
      pass_prod => '$1$aG60Esvv$xlyWAi8EQ2J1AochL6x061',
    },
    'dnsapi' => {
      uid       => '12386',
      pass_dev  => '$1$CqsqzFQz$lkNhzS8xzvVZHm1lZvp6I1',
      pass_prod => '$1$CqsqzFQz$lkNhzS8xzvVZHm1lZvp6I1',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'mmonit' => {
      uid       => '12387',
    },
    'thorp' => {
      uid       => '12388',
    },
    'userprofileapi' => {
      uid       => '12389',
    },
    'resposta' => {
      uid       => '12390',
    },
    'dashboard' => {
      uid       => '12391',
    },
    'vagrant' => {
      uid       => '12392',
    },
    'rubygems' => {
      uid       => '12393',
      pass_prod => '$1$akuu7wNy$OXu.Gen.s4A2zUNCGG7KA/',
    },
    'ingest' => {
      uid       => '12394',
    },
    'tvgrj' => {
      uid       => '12395',
    },
    'smartcapture' => {
      uid       => '12396',
    },
    'cadvlan' => {
      uid       => '12397',
    },
    'lockapi' => {
      uid       => '12398',
    },
    'marketplace' => {        # Cuidado: id duplicado
      uid       => '12399',
      allowdupe => true,
      pass_prod => '$1$CzUrCQf6$Tz3PM7GP.7KI8uuZkEexr/',
      groups    => ['marketuser'],
    },
    'compiler' => {           # Antigo uid usado no PMA
      uid       => '12399',
      gid       => '103',     # Fora do padrão
      #group     => 'cvs',
      allowdupe => true,
      groups    => [
        'globocom', 'nivel0', 'nivel1', 'nivel2', 'nivel3',
        'nivel4', 'nivel5', 'nivel6', 'nivel7', 'nivel8',
      ],
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'marketuser' => {
      uid       => '12400',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
    },
    'snapshot' => {
      uid       => '12401',
    },
    'cocoon' => {
      uid       => '12402',
    },
    'ping' => {
      uid       => '12403',
      pass_prod => '$1$Mvmj8N3d$yqErjzj02J7vd8qFWkmyB.',
      groups    => ['portal']
    },
    'userman' => {
      uid       => '12404',
    },
    # useradd -u 12405 -d /home/recommendation -m -k /etc/skel -s /bin/bash recommendation
    'recommendation' => {
      uid       => '12405',
    },
    # useradd -u 12406 -d /home/keystone -m -k /etc/skel -s /bin/bash keystone
    'keystone' => {
      uid       => '12406',
    },
    'pma' => {
      uid       => '12407',
      gid       => '501',   # Cuidado, fora do padrão
      allowdupe => true,
      pass_prod => '$1$DnxJ3Iza$WaQM5.9n.s9KZOGBIokoc1',
      groups    => [
        'cvs', 'globocom', 'nivel0', 'nivel1', 'nivel2', 'nivel3',
        'nivel4', 'nivel5', 'nivel6', 'nivel7', 'nivel8',
      ],
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    # useradd -u 12408 -d /home/senha -m -k /etc/skel -s /bin/bash senha
    'senha' => {
      uid       => '12408',
    },
    'mirror' => {
      uid       => '12409',
      pass_prod => '$1$7KI8uuZk$79nTzg5.lLHG.uPpILgOR1',
    },
    'transbordo' => {
      uid       => '12410',
      pass_prod => '$1$v/cu3rAr$tsPv4Bb3gU3NQCXug0d8x1',
    },
    'vbox' => {
      uid       => '12411',
      home      => '/opt/vbox',
      pass_prod => '$1$44484aab$GcrX3AasB.bT7FlOtQEIA/',
    },
    'mamulengo' => {
      uid       => '12412',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
    },
    'photographer' => {
      uid       => '12413',
      pass_dev  => 'false', # string por causa de um bug sinistro
      pass_prod => '$1$JiLlpxU.$PUZrOK37GpEY3/TH9ZSFQ/',
    },
    'rvm' => {
      uid       => '12414',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      pass_prod => 'false', # string por causa de um bug sinistro
    },
    'cma' => {
      uid       => '12415',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      pass_prod => 'false', # string por causa de um bug sinistro
    },
    'cma_' => {
      uid       => '12416',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      pass_prod => 'false', # string por causa de um bug sinistro
    },
    'virtuoso' => {     # Reservado, mas ainda não em uso oficial - Falar com o pessoal de DBA
      uid       => '12417',
      pass_prod => '$1$spHZUpG/$bzj4ku1O1v3.pEmXBXjXP.',
    },
    'fedora' => {
      uid       => '12418',
      pass_prod => '$1$vqLedYfX$6IUIxUdCww3cboduBYKnc0',
      groups    => ['mirror'],
    },
    'cadunweb' => {
        uid       => '12419',
        pass_prod => '$1$ymp1tLVd$Fcnday81HEV976JALlKmi/',
    },
    'globotvapi' => {
      uid       => '12420',
      pass_prod => '$1$ThwkdlJG$wzfcPTHFMnox3LluW44Tr.',
      groups    => [ 'thumborclient' ],
    },
    'vodstreaming' => {
      uid       => '12421',
      pass_prod => '$1$dF1KfkUC$fLABytIifJPLjuBnBSBav1',
    },
    'globotvvod' => {
      uid       => '12422',
      pass_prod => '$1$2d8S1nBi$SxtDwxVytQYwBz3vx8o2K.',
      groups    => [ 'thumborclient' ],
    },
    'cadunserver' => {
      uid         => '12423',
      pass_prod   => '$1$FSGny1U4$miuSD8TMbJjqYwXs3bFrr.',
    },
    'autenticacao' => {
      uid         => '12424',
      pass_prod   => '$1$2AZMiPwp$KmOwFWELP.SFTcTyQl1zd0',
    },
    'backuper' => {
      uid       => '12425',
    },
    'networkapi64' => {
      uid       => '12426',
    },
    'globotv_eventos' => {
      uid       => '12427',
      pass_prod => '$1$A1aWZ3zg$wiHpbwLA4mgzjRM5N3MGK/',
      groups    => ['globotv_eventos','thumborclient'],
    },
    'sentry' => {
      uid       => '12428',
      pass_prod => '$1$Dqycedgf$oL2D/P736vHdPgTVpOhnn/',
    },
    'netquery' => {
      uid       => '12429',
      pass_prod => '$1$cdexH1yz$3H8UXUTljyTiHV4PrwPP0/',
    },
    'ngit' => {             # Este será o usuário do ngit.globoi.com
      uid       => '12430',
      pass_prod => 'false', # sem senha em produção
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'zabbix' => {
      uid       => '12431',
      pass_prod => '7yA52NOCYt/Ag',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'apimanager' => {
      uid       => '12432',
      pass_prod => '$1$6PcYqu5w$N5kd4uMPsuSAMDmmUM5Bg/',
    },
    'rundeck' => {
      uid       => '12433',
      pass_prod => 'false', # sem senha em produção
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'hls' => {
      uid       => '12434',
      pass_prod => '$1$l1eH7cNK$WyKDez641w8VSq9odJPQT.', # sem senha em produção
    },
    'dns_proxy' => {
      uid       => '12435',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'monit'     => {
      uid       => '12436',
      home      => 'false',
      shell     => 'false',
      pass_dev  => 'false',
      pass_prod => 'false',
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    #
    # Aqui acaba o bloco padrão, insira novos usuários acima desta linha
    #
    # Aqui ficam os fora de ordem do final
    #
    # Grupos usados no CVS, a ordem é completamente maluca
    'nivel1' => {   # Grupo usado no CVS
      uid       => '12649',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'nivel2' => {   # Grupo usado no CVS
      uid       => '12650',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'nivel0' => {   # Grupo usado no CVS
      uid       => '12652',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'nivel5' => {   # Grupo usado no CVS
      uid       => '12653',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'nivel4' => {   # Grupo usado no CVS
      uid       => '12654',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'nivel3' => {   # Grupo usado no CVS
      uid       => '12655',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'nivel6' => {   # Grupo usado no CVS
      uid       => '12711',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
#    'oldgit' => {
#      uid       => '12828',  # usado por sistemas antigos, não deve mais ser usado
#    },
    'nivel7' => {   # Grupo usado no CVS
      uid       => '12829',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
    'nivel8' => {   # Grupo usado no CVS
      uid       => '12859',
      pass_prod => 'false', # string por causa de um bug sinistro
      pass_dev  => 'false', # string por causa de um bug sinistro
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
      system    => true,    # não pertence a nenhuma aplicação do portal
    },
#    'git' => {
#      uid       => '12879',  # usado por sistemas antigos, não deve mais ser usado
#    },
    'dnx' => {
      uid       => '12880',
    },
    'webmediadocs' => {
      uid       => '12881',
    },
    'webmediaapi' => {
      uid       => '12882',
      pass_prod => '$1$806Pqgec$cCKTVkutmddJcMvEA4WDX/',
    },
    'webmediasync' => {
      uid       => '12883',
    },
    'busca2' => {
      uid       => '13003', # para ficar compatível com apps antigas
      pass_prod => '$1$sZEtlbAJ$F4jygQlwgLXsVKriSyKS31',
      groups    => ['portal', 'busca'],
      usepma    => true,
    },
    'billing2' => {
      uid       => '13370',
      usepma    => true,
    },
    'suporte_billing2' => {
      uid       => '13371',
    },
    'rpmmaker' => {
      uid       => '14100',
    },
    'jogos' => {
      uid       => '14107', # não estava no users.txt
    },
    'techtudo' => {
      uid       => '14109', # não estava no users.txt
      pass_prod => '$1$Kojx5pA2$cs6NwR15KkJVit5fCC.sw1',
      groups    => ['portal', 'thumborclient'],
    },
    'eject' => {        # Para o CachOS eject
      uid       => '22222',
      pass_prod => '$1$HgOTuLWO$.BFbTMvHlz28sQPaRLIXu0',
      gecos     => 'Usuario do CachosEject',    # XXX - Nao implementado
    },
    'hadoop' => {        # Para a farm de Hadoop
      pass_prod => '$1$Yg1x3Lt9$zzNNd9ba5mO6r8.DUsVj1/',
      uid       => '33333',
    },
    'feed' => {        # Para a farm de feed
      pass_prod => '$1$uy9qJp8F$RfrxuVDq.rZiLV0mYEaqj.',
      uid       => '14110',
    },
    'feed_http' => {   # Para a farm de feed
      pass_prod => '!!',
      uid       => '14111',
      shell     => 'false', # string por causa de um bug sinistro
      home      => 'false', # string por causa de um bug sinistro
    },

    # Relembrando, NAO INSERIR AQUI, veja onde inserir acima...
  }
}

# EOF
